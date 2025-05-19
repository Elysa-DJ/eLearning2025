import 'package:get/get.dart';

class ProfileController extends GetxController {
  var enrollments = <Map<String, dynamic>>[].obs;
  var loading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEnrollments();
  }

  void fetchEnrollments() async {
    loading.value = true;
    await Future.delayed(Duration(seconds: 2)); // Simule un chargement

    try {
      enrollments.value = [
        {'id': 1, 'title': 'Flutter Basics'},
        {'id': 2, 'title': 'Advanced Dart'},
      ];
      error.value = '';
    } catch (e) {
      error.value = 'Failed to load courses';
    } finally {
      loading.value = false;
    }
  }
}
