



import '../models/quiz.dart';

class QuizService {
  Future<Quiz> fetchQuiz(String courseId, String chapterId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Simulated quiz data
    return Quiz(
      id: 'quiz101',
      courseId: courseId,
      chapterId: chapterId,
      title: 'Chapter Quiz',
      description: 'Test your knowledge of the chapter content.',
      timeLimit: 15,
      passingScore: 70,
      questions: [
        Question(
          id: 'q1',
          type: QuestionType.multipleChoice,
          text: 'What is the main purpose of state management in Flutter?',
          options: [
            Option(
              id: 'a',
              text: 'To manage app navigation',
            ),
            Option(
              id: 'b',
              text: 'To handle user interface updates efficiently',
            ),
            Option(
              id: 'c',
              text: 'To store data locally',
            ),
            Option(
              id: 'd',
              text: 'To make API calls',
            ),
          ],
        ),
        Question(
          id: 'q2',
          type: QuestionType.multipleSelect,
          text: 'Which of the following are valid state management solutions in Flutter?',
          options: [
            Option(
              id: 'a',
              text: 'GetX',
            ),
            Option(
              id: 'b',
              text: 'Provider',
            ),
            Option(
              id: 'c',
              text: 'Bloc',
            ),
            Option(
              id: 'd',
              text: 'Redux',
            ),
          ],
        ),
        Question(
          id: 'q3',
          type: QuestionType.text,
          text: 'What widget would you use to create a scrollable list of items?',
          multiline: false,
        ),
        Question(
          id: 'q4',
          type: QuestionType.calculation,
          text: 'If a ListView has 3 items and each item has 2 child widgets, how many widgets are rendered in total?',
          formula: 'Parent + (Items × Children)',
          unit: 'widgets',
        ),
      ],
    );
  }

  Future<QuizSubmission> submitQuizAnswers(
    String courseId,
    String chapterId,
    String quizId,
    Map<String, dynamic> answers,
    int timeSpent,
  ) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Simulate quiz grading
    final score = 85; // Simulated score
    final correctCount = 8;
    final incorrectCount = 1;
    final unansweredCount = 1;
    
    return QuizSubmission(
      id: 'submission${DateTime.now().millisecondsSinceEpoch}',
      quizId: quizId,
      userId: 'user1',
      score: score,
      timeSpent: timeSpent,
      correctCount: correctCount,
      incorrectCount: incorrectCount,
      unansweredCount: unansweredCount,
      correctAnswers: {
        'q1': 'b',
        'q2': ['a', 'b', 'c'],
        'q3': 'ListView',
        'q4': '7',
      },
      userAnswers: answers,
      feedback: score >= 90
          ? 'Excellent work! You have a strong understanding of the concepts.'
          : score >= 80
              ? 'Great job! You have a good grasp of the material.'
              : score >= 70
                  ? 'Good effort! Review some concepts to improve further.'
                  : 'Keep practicing! Review the chapter material and try again.',
    );
  }
}