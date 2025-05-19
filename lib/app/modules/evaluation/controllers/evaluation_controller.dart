import 'package:get/get.dart';

import '../../../data/models/evaluation.dart';
import '../../../data/services/evaluation_service.dart';

class EvaluationController extends GetxController {
  final EvaluationService _evaluationService;
  
  final evaluation = Rx<Evaluation?>(null);
  final isLoading = true.obs;
  final error = Rx<String?>(null);

  EvaluationController(this._evaluationService);

  @override
  void onInit() {
    super.onInit();
    loadEvaluation();
  }

  Future<void> loadEvaluation() async {
    try {
      final courseId = Get.parameters['courseId'];
      final chapterId = Get.parameters['chapterId'];
      
      if (courseId == null || chapterId == null) {
        throw Exception('Course ID or Chapter ID not provided');
      }

      final evaluationData = await _evaluationService.fetchChapterEvaluation(
        courseId,
        chapterId,
      );
      
      evaluation.value = evaluationData;
    } catch (e) {
      error.value = 'Failed to load evaluation. Please try again later.';
      print('Error loading evaluation: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void startQuiz() {
    final courseId = Get.parameters['courseId'];
    final chapterId = Get.parameters['chapterId'];
    
    Get.toNamed(
      '/quizz',
      parameters: {
        'courseId': courseId!,
        'chapterId': chapterId!,
      },
    );
  }
}