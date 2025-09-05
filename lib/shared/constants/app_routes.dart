import 'package:get/get.dart';
import 'package:khotwa/bindings/donner_binding.dart';
import 'package:khotwa/bindings/supervisor_binding.dart';
import 'package:khotwa/bindings/volunteer_binding.dart';
import 'package:khotwa/view/Home_Page/Home_Page/Home_Page_Donor.dart';
import 'package:khotwa/view/Home_Page/Home_Page/Home_Page_Volunteer.dart';
import 'package:khotwa/view/Home_Page/Home_Page/Home_page_Supervisor.dart';
import 'package:khotwa/view/donner/donate/donate_page.dart';
import 'package:khotwa/view/donner/my_donations/my_donations_page.dart';
import 'package:khotwa/view/event_and_projects/my_events_page.dart';
import 'package:khotwa/view/supervisor/attendence/attendence_page.dart';
import 'package:khotwa/view/supervisor/attendence/show_qr_in_page.dart';
import 'package:khotwa/view/supervisor/create_task/create_task_page.dart';
import 'package:khotwa/view/supervisor/feedback/feedback_page.dart';
import 'package:khotwa/view/tasks/tasks_page.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String verifyEmail = '/verify-email';
  static const String changePassword = '/change-password';
  
  // Donor routes
  static const String donorHome = '/donor-home';
  static const String myDonations = '/my-donations';
  static const String donate = '/donate';
  static const String confirmDonation = '/confirm-donation';
  
  // Volunteer routes
  static const String volunteerHome = '/volunteer-home';
  static const String volunteerEvents = '/volunteer-events';
  static const String volunteerTasks = '/volunteer-tasks';
  static const String volunteerEvaluations = '/volunteer-evaluations';
  static const String volunteerBadges = '/volunteer-badges';
  static const String submitFeedback = '/submit-feedback';
  
  // Supervisor routes
  static const String supervisorHome = '/supervisor-home';
  static const String attendance = '/attendance';
  static const String showQR = '/show-qr';
  static const String createEvaluation = '/create-evaluation';
  static const String createTask = '/create-task';
  static const String eventEvaluations = '/event-evaluations';
  
  static List<GetPage> routes = [
    // Existing routes...
    
    // Donor routes
    GetPage(
      name: donorHome,
      page: () => HomePageDonor(),
      binding: DonorBinding(),
    ),
    GetPage(
      name: myDonations,
      page: () => MyDonationsPage(),
      binding: DonorBinding(),
    ),
    GetPage(
      name: donate,
      page: () => DonatePage(),
      binding: DonorBinding(),
    ),
    
    // Volunteer routes
    GetPage(
      name: volunteerHome,
      page: () => HomePageVolunteer(),
      binding: VolunteerBinding(),
    ),
    GetPage(
      name: volunteerEvents,
      page: () => MyEventsPage(),
      binding: VolunteerBinding(),
    ),
    GetPage(
      name: volunteerTasks,
      page: () => TasksPage(),
      binding: VolunteerBinding(),
    ),
    
    // Supervisor routes
    GetPage(
      name: supervisorHome,
      page: () => HomePageSupervisor(),
      binding: SupervisorBinding(),
    ),
    // GetPage(
    //   name: attendance,
    //   page: () => AttendancePage(),
    //   binding: SupervisorBinding(),
    // ),
    GetPage(
      name: showQR,
      page: () => ShowQrInPage(),
      binding: SupervisorBinding(),
    ),
    GetPage(
      name: createEvaluation,
      page: () => VolunteerFeedbackPage(),
      binding: SupervisorBinding(),
    ),
    GetPage(
      name: createTask,
      page: () => CreateTaskPage(),
      binding: SupervisorBinding(),
    ),
  ];
}