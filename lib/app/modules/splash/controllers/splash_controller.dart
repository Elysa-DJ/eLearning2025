import 'package:learning_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  Future<void> checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 10));
    Get.offAllNamed(Routes.ONBOARDING);
  }
}
