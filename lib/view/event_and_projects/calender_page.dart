// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:khotwa/shared/constants/colors.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:khotwa/controller/volunteer_controller.dart';
// import 'package:khotwa/model/events_model.dart';

// class MyEventsCalendarPage extends StatelessWidget {
//   final VolunteerController _controller = Get.put(VolunteerController());

//   MyEventsCalendarPage({super.key});

//   Map<DateTime, List<EventModel>> _buildEventsMap(List<EventModel> events) {
//     final Map<DateTime, List<EventModel>> map = {};
//     for (var event in events) {
//       final dateKey = DateTime(event.date.year, event.date.month, event.date.day);
//       map.putIfAbsent(dateKey, () => []).add(event);
//     }
//     return map;
//   }

//   List<EventModel> _getEventsForDay(DateTime day, Map<DateTime, List<EventModel>> map) {
//     final dateKey = DateTime(day.year, day.month, day.day);
//     return map[dateKey] ?? [];
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//     final dateTextColor = isDark ? Colors.white : Colors.black;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: isDark ? primaryColor : secondaryColor,
//         title: Text("My Events Calendar".tr),
//       ),
//       body: Obx(() {
//         if (_controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         final eventsMap = _buildEventsMap(_controller.myEvents);

//         return TableCalendar<EventModel>(
//           firstDay: DateTime.utc(2020, 1, 1),
//           lastDay: DateTime.utc(2030, 12, 31),
//           focusedDay: DateTime.now(),
//           calendarFormat: CalendarFormat.month,
//           startingDayOfWeek: StartingDayOfWeek.sunday,
//           eventLoader: (day) => _getEventsForDay(day, eventsMap),
//           headerVisible: true,
//           calendarStyle: CalendarStyle(
//             outsideDaysVisible: false,
//             cellMargin: EdgeInsets.zero,
//           ),
//           calendarBuilders: CalendarBuilders(
//             defaultBuilder: (context, day, focusedDay) {
//               final dayEvents = _getEventsForDay(day, eventsMap);
//               return Container(
//                 padding: const EdgeInsets.all(2),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     for (var event in dayEvents)
//                       Text(
//                         event.title,
//                         style: const TextStyle(
//                           fontSize: 7,
//                           fontWeight: FontWeight.bold,
//                           color: secondaryColor,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     const Spacer(),
//                     Text(
//                       '${day.day}',
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.bold,
//                         color: dateTextColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//             todayBuilder: (context, day, focusedDay) {
//               final dayEvents = _getEventsForDay(day, eventsMap);
//               return Container(
//                 padding: const EdgeInsets.all(2),
//                 decoration: BoxDecoration(
//                   color: isDark ? Colors.white12 : Colors.blue.shade50,
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     for (var event in dayEvents)
//                       Text(
//                         event.title,
//                         style: const TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     const Spacer(),
//                     Text(
//                       '${day.day}',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: dateTextColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       }),
//     );
//   }
// }
