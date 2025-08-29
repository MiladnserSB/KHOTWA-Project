import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:khotwa/main.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await _requestNotificationPermission();

    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings();
    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final payload = response.payload;
        if (payload != null) {
          _openMessageScreen(payload);
        }
      },
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'fcm_channel',
      'FCM Notifications',
      description: 'Channel for FCM notifications',
      importance: Importance.high,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen(_showLocalNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final payload = _createPayload(message);
      _openMessageScreen(payload);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final payload = _createPayload(message);
        _openMessageScreen(payload);
      }
    });

    String? token = await _messaging.getToken();
    print("🔑 FCM Token: $token");
  }

  Future<void> _requestNotificationPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("✅ المستخدم وافق على الإشعارات");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print("⚠️ إذن مؤقت");
    } else {
      print("❌ المستخدم رفض الإذن");
    }
  }

  String _createPayload(RemoteMessage message) {
    return jsonEncode({
      "title": message.notification?.title ?? "",
      "body": message.notification?.body ?? "",
      "data": message.data,
    });
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'fcm_channel',
      'FCM Notifications',
      channelDescription: 'Channel for FCM notifications',
      importance: Importance.max,
      priority: Priority.high,
      autoCancel: true,
      ongoing: false,
    );
    const platformDetails = NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      platformDetails,
      payload: _createPayload(message),
    );
  }

  void _openMessageScreen(String payload) {
    final Map<String, dynamic> data = jsonDecode(payload);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (_) => MessageScreen(data: data)),
      );
    });
  }
}

class MessageScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  const MessageScreen({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    final title = data["title"] ?? "";
    final body = data["body"] ?? "";
    final extraData = Map<String, dynamic>.from(data["data"] ?? {});

    return Scaffold(
      appBar: AppBar(title: const Text("تفاصيل الرسالة")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("📄 العنوان: $title",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("📝 المحتوى: $body", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            const Text("📦 بيانات إضافية:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...extraData.entries.map(
              (e) => Text("${e.key}: ${e.value}", style: const TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
