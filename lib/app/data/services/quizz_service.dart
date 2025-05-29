



import '../models/quiz.dart';

class QuizService {
 Future<Quiz> fetchQuiz(String courseId, String chapterId) async {
    // Simule un délai d'attente de l'API
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Données du quiz simulées
    return Quiz(
      id: 'quiz101',
      courseId: courseId,
      chapterId: chapterId,
      title: 'Quiz du chapitre',
      description: 'Testez vos connaissances sur le contenu du chapitre.',
      timeLimit: 15,
      passingScore: 70,
      questions: [
        Question(
          id: 'q1',
          type: QuestionType.multipleChoice,
          text: 'Quel est le principal objectif de la gestion d’état dans Flutter ?',
          options: [
            Option(id: 'a', text: 'Gérer la navigation de l’application'),
            Option(id: 'b', text: 'Gérer efficacement les mises à jour de l’interface utilisateur'),
            Option(id: 'c', text: 'Stocker les données localement'),
            Option(id: 'd', text: 'Effectuer des appels API'),
          ],
        ),
        Question(
          id: 'q2',
          type: QuestionType.multipleSelect,
          text: 'Lesquelles des solutions suivantes sont valides pour la gestion d’état dans Flutter ?',
          options: [
            Option(id: 'a', text: 'GetX'),
            Option(id: 'b', text: 'Provider'),
            Option(id: 'c', text: 'Bloc'),
            Option(id: 'd', text: 'Redux'),
          ],
        ),
        Question(
          id: 'q3',
          type: QuestionType.text,
          text: 'Quel widget utiliseriez-vous pour créer une liste défilante d’éléments ?',
          multiline: false,
        ),
        Question(
          id: 'q4',
          type: QuestionType.calculation,
          text: 'Si un ListView contient 3 éléments et que chaque élément a 2 widgets enfants, combien de widgets sont rendus au total ?',
          formula: 'Parent + (Éléments × Enfants)',
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
    // Simule un délai d’attente de l’API
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Simulation de la notation du quiz
    final score = 85;
    final correctCount = 8;
    final incorrectCount = 1;
    final unansweredCount = 1;
    
    return QuizSubmission(
      id: 'soumission${DateTime.now().millisecondsSinceEpoch}',
      quizId: quizId,
      userId: 'utilisateur1',
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
          ? 'Excellent travail ! Vous avez une excellente compréhension des concepts.'
          : score >= 80
              ? 'Très bon travail ! Vous avez une bonne maîtrise du sujet.'
              : score >= 70
                  ? 'Bon effort ! Revoyez quelques notions pour vous améliorer.'
                  : 'Continuez à pratiquer ! Revoyez le contenu du chapitre et réessayez.',
    );
  }
}