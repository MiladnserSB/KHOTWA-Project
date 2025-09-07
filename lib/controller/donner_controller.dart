import 'package:get/get.dart';
import 'package:khotwa/model/create_donation_model.dart';
import 'package:khotwa/model/events_model.dart';
import 'package:khotwa/model/my_donations_model.dart';
import 'package:khotwa/model/projects_model.dart';
import 'package:khotwa/model/top_projects_model.dart';
import 'package:khotwa/service/donner_service.dart';
import 'package:khotwa/widgets/custom_snack_bar.dart';

class DonorController extends GetxController {
  final DonationService _donationService = DonationService();

  var myDonations = <DonationModel>[].obs;
  var allEvents = <EventModel>[].obs;
  var topProjects = <TopProject>[].obs;
  var allProjects = <ProjectModel>[].obs;
  var isLoading = false.obs;
  var isLoadingDonations = false.obs;
  var isLoadingEvents = false.obs;
  var isLoadingProjects = false.obs;
  var isLoadingTopProjects = false.obs;

  @override
  void onInit() {
    super.onInit();
        fetchAllEvents();
    fetchTopProjects();
    fetchAllProjects();
    fetchMyDonations();

  }

  Future<void> fetchMyDonations() async {
    try {
      isLoadingDonations.value = true;
      final donationsResponse = await _donationService.getMyDonations();
      myDonations.assignAll(donationsResponse.data);
    } catch (e) {
      CustomSnackbar.show(
        type: SnackbarType.error,
        title: 'Error',
        message: 'Failed to fetch donations',
      );
    } finally {
      isLoadingDonations.value = false;
    }
  }

  Future<CreateDonationModel?> createDonation(Map<String, dynamic> donationData) async {
    try {
      isLoadingDonations.value = true;
      final createdDonation = await _donationService.createDonation(donationData);

      await fetchMyDonations();

      CustomSnackbar.show(
        type: SnackbarType.success,
        title: 'Success',
        message: createdDonation.message,
      );

      return createdDonation;
    } catch (e) {
      CustomSnackbar.show(
        type: SnackbarType.error,
        title: 'Error',
        message: 'Failed to create donation',
      );
      return null;
    } finally {
      isLoadingDonations.value = false;
    }
  }

  Future<void> confirmDonation(Map<String, dynamic> paymentData) async {
    try {
      isLoadingDonations.value = true;
      await _donationService.confirmDonation(paymentData);

      await fetchMyDonations();

      CustomSnackbar.show(
        type: SnackbarType.success,
        title: 'Success',
        message: 'Donation confirmed successfully',
      );
    } catch (e) {
      CustomSnackbar.show(
        type: SnackbarType.error,
        title: 'Error',
        message: 'Failed to confirm donation',
      );
    } finally {
      isLoadingDonations.value = false;
    }
  }

  Future<void> fetchAllEvents() async {
    try {
      isLoadingEvents.value = true;
      final events = await _donationService.getAllEvents();
      allEvents.assignAll(events);
    } catch (e) {
      // handle error if needed
    } finally {
      isLoadingEvents.value = false;
    }
  }

  Future<void> fetchAllProjects() async {
    try {
      isLoadingProjects.value = true;
      final projects = await _donationService.getAllProjects();
      allProjects.assignAll(projects);
    } catch (e) {
      // handle error if needed
    } finally {
      isLoadingProjects.value = false;
    }
  }

  Future<void> fetchTopProjects() async {
    try {
      isLoadingTopProjects.value = true;
      final projects = await _donationService.getTopProjects();
      topProjects.assignAll(projects);
    } catch (e) {
      // handle error if needed
    } finally {
      isLoadingTopProjects.value = false;
    }
  }
}
