import 'package:get/get.dart';
import 'package:khotwa/model/create_donation_model.dart';
import 'package:khotwa/model/my_donations_model.dart';
import 'package:khotwa/service/donner_service.dart';
import 'package:khotwa/widgets/custom_snack_bar.dart';


class DonorController extends GetxController {
  final DonationService _donationService = DonationService();

  var myDonations = <DonationModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchMyDonations();
    super.onInit();
  }

  Future<void> fetchMyDonations() async {
    try {
      isLoading(true);
      final donationsResponse = await _donationService.getMyDonations();
      myDonations.assignAll(donationsResponse.data);
    } catch (e) {
      CustomSnackbar.show(
        type: SnackbarType.error,
        title: 'Error',
        message: 'Failed to fetch donations',
      );
    } finally {
      isLoading(false);
    }
  }

  Future<CreateDonationModel?> createDonation(Map<String, dynamic> donationData) async {
    try {
      isLoading(true);
      final createdDonation = await _donationService.createDonation(donationData);

      // Refresh donations
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
      isLoading(false);
    }
  }

  Future<void> confirmDonation(Map<String, dynamic> paymentData) async {
    try {
      isLoading(true);
      await _donationService.confirmDonation(paymentData);

      // Refresh donations
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
      isLoading(false);
    }
  }
}
