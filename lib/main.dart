// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khotwa/Localizations/ArabicLocalization.dart';
import 'package:khotwa/Localizations/EnglishLocalization.dart';
import 'package:khotwa/Notification/Notification_Service.dart';
import 'package:khotwa/controller/Settings_Lang_Controller.dart';
import 'package:khotwa/controller/theme_controller.dart';
import 'package:khotwa/maps/maps_screen.dart';
// import 'package:khotwa/firebase_options.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/Home_Page/Animted_bottom/Animated_Bottom_Bar_Donor.dart';
import 'package:khotwa/view/Home_Page/Animted_bottom/Animated_Bottom_Bar_Supervisor.dart';
import 'package:khotwa/view/Home_Page/Animted_bottom/Animated_Bottom_Bar_Visitor.dart';
import 'package:khotwa/view/Home_Page/Animted_bottom/Animated_Bottom_Bar_Volunteer.dart';
import 'package:khotwa/view/donner/donate/donate_page.dart';
import 'package:khotwa/view/event_and_projects/event_details/map_location_page.dart';
import 'package:khotwa/view/notifications/notifications_list_page.dart';


// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   print("📩 إشعار في الخلفية (Background):");
//   print("   📄 العنوان: ${message.notification?.title}");
//   print("   📝 المحتوى: ${message.notification?.body}");
// }
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Hive.initFlutter();
  await Hive.openBox('authBox');

  Get.put(ThemeController());
  Get.put(SettingsLangController());

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
        // NotificationService().init();

    final theme = Theme.of(context);

    final themeController = Get.find<ThemeController>();
    final settingsController = Get.find<SettingsLangController>();

    return Obx(() {
      return GetMaterialApp(
              // navigatorKey: navigatorKey,

        debugShowCheckedModeBanner: false,
        translations: MyTranslations(),
        locale: settingsController.locale.value,
        fallbackLocale: const Locale('en'),
        title: 'Khotwa App',

        // 🌞 Theme Light
        theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 1,
          ),
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.black),
          ),

          datePickerTheme: DatePickerThemeData(
            headerForegroundColor: Colors.black,
            weekdayStyle: const TextStyle(color: Colors.black54),

            dayForegroundColor: WidgetStateProperty.resolveWith<Color?>(
              (states) => states.contains(WidgetState.selected)
                  ? Colors.white
                  : Colors.grey,
            ),

            dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>(
              (states) => states.contains(WidgetState.selected)
                  ? Colors.black
                  : Colors.transparent,
            ),

            todayForegroundColor: WidgetStateProperty.all(Colors.black),
            todayBackgroundColor: WidgetStateProperty.all(Colors.transparent),
            todayBorder: const BorderSide(color: Colors.black),

            yearForegroundColor: WidgetStateProperty.all(Colors.grey),
            yearBackgroundColor: WidgetStateProperty.resolveWith<Color?>(
              (states) =>
                  states.contains(WidgetState.selected) ? Colors.black : null,
            ),
          ),

          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.black),
          ),
        ),

        // 🌑 Theme Dark
        darkTheme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            elevation: 1,
          ),
          scaffoldBackgroundColor: Colors.black,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
          ),

          datePickerTheme: DatePickerThemeData(
            headerForegroundColor: Colors.white,
            weekdayStyle: const TextStyle(color: Colors.white70),

            dayForegroundColor: WidgetStateProperty.resolveWith<Color?>(
              (states) => states.contains(WidgetState.selected)
                  ? Colors.black
                  : Colors.grey,
            ),

            dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>(
              (states) => states.contains(WidgetState.selected)
                  ? Colors.white
                  : Colors.transparent,
            ),

            todayForegroundColor: WidgetStateProperty.all(Colors.black),
            todayBackgroundColor: WidgetStateProperty.all(Colors.transparent),
            todayBorder: const BorderSide(color: Colors.white),

            yearForegroundColor: WidgetStateProperty.all(Colors.grey),
            yearBackgroundColor: WidgetStateProperty.resolveWith<Color?>(
              (states) =>
                  states.contains(WidgetState.selected) ? Colors.white : null,
            ),
          ),

          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: theme.brightness == Brightness.dark
                  ? Colors.black
                  : thirdColor,
            ),
          ),
        ),

        themeMode: themeController.themeMode,
        home: AnimatedBottomBarPageVolunteer()
      );
    });
  }
}

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    ...EnglishLocalization().keys,
    ...ArabicLocalization().keys,
  };
}








// initialRoute: AppRoutes.login,
//       getPages: [
//         GetPage(
//           name: AppRoutes.splash,
//           page: () => const SplashScreen(),
//           binding: SplashBinding(),
//         ),
//         GetPage(name: AppRoutes.intro, page: () => const IntroScreen()),
//         GetPage(name: AppRoutes.login, page: () => LoginPage()),
//           GetPage(name: AppRoutes.verifyEmail, page: () =>  VerifyEmailPage()),
//         GetPage(name: AppRoutes.homeVolunteer, page: () => HomePageVoulunteer()),
//         GetPage(name: AppRoutes.changePassword, page: () => ChangingPasswordPage()),
//       ],
//       import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:khotwa/maps/maps_screen.dart';
// import 'package:khotwa/maps/place_picker_widget.dart';
// import 'package:latlong2/latlong.dart';


// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const YamenMapPreview(),
//     );
//   }
// }

// class YamenMapPreview extends StatefulWidget {
//   const YamenMapPreview({super.key});

//   @override
//   State<YamenMapPreview> createState() => _YamenMapPreviewState();
// }

// class _YamenMapPreviewState extends State<YamenMapPreview> {


//   //مشان تحفظوا الموقع المختار
//   PickedData? pickedData;

//   MapController mapController = MapController();
//   var addressController = TextEditingController();

//   UniqueKey _mapKey = UniqueKey();





//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: const Text("Yamen Map Preview"),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               const Text(
//                 'the map location widget looks like this:',
//               ),



//               if(pickedData!=null)
//                 Container(
//                   clipBehavior: Clip.hardEdge,
//                   height: MediaQuery.of(context).size.height * 0.3,
//                   foregroundDecoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(
//                           color: Colors.blueGrey,
//                           width: MediaQuery.of(context).size.height * 0.001)),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(
//                           color: Colors.blueGrey,
//                           width: MediaQuery.of(context).size.height * 0.001)),
//                   child: Stack(
//                     children: [
//                       FlutterMap(
//                           key: _mapKey,

//                           mapController: mapController,
//                           options: MapOptions(
//                               interactiveFlags: InteractiveFlag.none,
//                               center: LatLng(
//                                   pickedData!
//                                       .latLong
//                                       .latitude,
//                                   pickedData!
//                                       .latLong
//                                       .longitude),
//                               zoom: 17,
//                               maxZoom: 19,
//                               maxBounds: LatLngBounds(
//                                   LatLng(
//                                     24.29200,
//                                     46.22700,
//                                   ),
//                                   LatLng(
//                                     25.09800,
//                                     47.20200,
//                                   ))),
//                           children: [
//                             TileLayer(
//                               urlTemplate:
//                               "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
//                               userAgentPackageName:
//                               'dev.fleaflet.flutter_map.example',
//                             ),
//                           ]),
//                       const Positioned.fill(
//                           child: IgnorePointer(
//                             child: Center(
//                               child: Icon(
//                                 Icons.location_pin,
//                                 size: 50,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                           )),
//                     ],
//                   ),
//                 ),

//               if(pickedData==null)
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: (_) => PlacePicker(
//                           limitLocation: "دمشق",
//                           onPicked: (pickedData) {
//                             setState(() {
//                               this.pickedData= pickedData;
//                             });
//                           },
//                         )));
//                   },
//                   child: Container(
//                     clipBehavior: Clip.antiAliasWithSaveLayer,
//                     height: MediaQuery.of(context).size.height * 0.3,
//                     decoration: BoxDecoration(
//                         image: const DecorationImage(
//                             image: NetworkImage("https://th-i.thgim.com/public/migration_catalog/article12284026.ece/alternates/FREE_320/Aleppo.jpg"),
//                             fit: BoxFit.cover),
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                             color: Colors.blueGrey,
//                             width: MediaQuery.of(context).size.height * 0.001)),
//                   ),
//                 )

//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
