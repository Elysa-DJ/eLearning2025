
import 'package:get/get.dart';



class QuizzController extends GetxController {
    var selectedAnswers = {}.obs;
    var currentQuestionIndex = 0.obs;

  final questions = [
    {
      "question": "What is the capital of France?",
      "type": "multiple-choice",
      "options": ["Paris", "London", "Rome", "Berlin"],
    },
    {
      "question": "What is 5 + 7?",
      "type": "calculation",
    },
    {
      "question": "Write your opinion about online education.",
      "type": "text",
    },
  ];

  void selectOption(int index, dynamic value) {
    selectedAnswers[index] = value;
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
  }

  void submitQuiz() {
    // Logique de soumission
    print('Answers: $selectedAnswers');
  }
}