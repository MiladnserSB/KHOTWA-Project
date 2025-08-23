import 'package:get/get.dart';
import 'package:khotwa/service/donner_service.dart';
import 'package:khotwa/widgets/custom_snack_bar.dart'; 

class DonorController extends GetxController {
  final DonationService _donationService = DonationService();
  var myDonations = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchMyDonations();
    super.onInit();
  }

  Future<void> fetchMyDonations() async {
    try {
      isLoading(true);
      final donations = await _donationService.getMyDonations();
      myDonations.assignAll(donations);
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

  Future<void> createDonation(Map<String, dynamic> donationData) async {
    try {
      isLoading(true);
      await _donationService.createDonation(donationData);
      await fetchMyDonations();
      CustomSnackbar.show(
        type: SnackbarType.success,
        title: 'Success',
        message: 'Donation created successfully',
      );
    } catch (e) {
      CustomSnackbar.show(
        type: SnackbarType.error,
        title: 'Error',
        message: 'Failed to create donation',
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> confirmDonation(int donationId, Map<String, dynamic> paymentData) async {
    try {
      isLoading(true);
      await _donationService.confirmDonation(donationId, paymentData);
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
