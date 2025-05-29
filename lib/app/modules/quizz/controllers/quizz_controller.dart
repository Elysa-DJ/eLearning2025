
import 'package:get/get.dart';

import '../../../data/models/quiz.dart';
import '../../../data/services/quizz_service.dart';



class QuizzController extends GetxController {
    final QuizService quizService = QuizService();

  // Quiz observable
  final Rxn<Quiz> quiz = Rxn<Quiz>();

  // Index de la question actuelle
  final RxInt currentQuestionIndex = 0.obs;

  // Réponses sélectionnées par questionId
  final RxMap<String, dynamic> selectedAnswers = <String, dynamic>{}.obs;

  // Chargement du quiz
  Future<void> loadQuiz(String courseId, String chapterId) async {
    try {
      final result = await quizService.fetchQuiz(courseId, chapterId);
      quiz.value = result;
      selectedAnswers.clear(); // Réinitialiser les réponses au chargement
      currentQuestionIndex.value = 0;
    } catch (e) {
      Get.snackbar("Erreur", "Impossible de charger le quiz.");
    }
  }

  // Aller à la question suivante
  void nextQuestion() {
    if (currentQuestionIndex.value < (quiz.value?.questions.length ?? 1) - 1) {
      currentQuestionIndex.value++;
    }
  }

  // Aller à la question précédente
  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
  }

  // Enregistrement d'une réponse
  void selectOption(String questionId, dynamic answer) {
    selectedAnswers[questionId] = answer;
  }

  // Soumission du quiz
  Future<void> submitQuiz() async {
    if (quiz.value == null) return;

    try {
      final result = await quizService.submitQuizAnswers(
        quiz.value!.courseId,
        quiz.value!.chapterId,
        quiz.value!.id,
        selectedAnswers,
        60, // Temps passé (simulé)
      );

      Get.defaultDialog(
        title: "Résultat",
        middleText: "Score: ${result.score}%\n\n${result.feedback}",
        textConfirm: "OK",
        onConfirm: () => Get.back(),
      );
    } catch (e) {
      Get.snackbar("Erreur", "Échec de la soumission du quiz.");
    }
  }
}