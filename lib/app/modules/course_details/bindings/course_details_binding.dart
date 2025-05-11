import 'package:get/get.dart';

import '../controllers/course_details_controller.dart';

class CourseDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final course = Get.arguments['course'];
    Get.lazyPut<CourseDetailsController>(
      () => CourseDetailsController(course: course),
    );
  }
}
