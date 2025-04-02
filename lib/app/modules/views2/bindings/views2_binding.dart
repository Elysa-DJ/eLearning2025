import 'package:get/get.dart';

import '../controllers/views2_controller.dart';

class Views2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Views2Controller>(
      () => Views2Controller(),
    );
  }
}
