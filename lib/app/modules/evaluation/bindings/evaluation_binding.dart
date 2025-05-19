import 'package:get/get.dart';

import '../../../data/services/evaluation_service.dart';
import '../controllers/evaluation_controller.dart';

class EvaluationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EvaluationController>(
      () => EvaluationController(EvaluationService()),
    );
  }
}
