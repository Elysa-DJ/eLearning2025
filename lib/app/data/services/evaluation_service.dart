
import '../models/evaluation.dart';

class EvaluationService {
  Future<Evaluation> fetchChapterEvaluation(String courseId, String chapterId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Simulated evaluation data
    return Evaluation(
      id: 'eval101',
      courseId: courseId,
      chapterId: chapterId,
      title: 'Évaluation du Chapitre ',
      description: 'Test your understanding of the concepts covered in this chapter.',
      totalQuestions: 10,
      timeLimit: 15,
      passingScore: 70,
      maxAttempts: 3,
      instructions: [
        'Lisez attentivement chaque question avant de répondre.',
        'Vous pouvez modifier vos réponses avant de soumettre le quiz.',
        'Certaines questions peuvent avoir plusieurs bonnes réponses.',
        'You have 15 minutes to complete this quiz.',
        'Vous devez obtenir 70% pour réussir cette évaluation.'
      ],
      questionTypes: [
         QuestionType(
        name: 'Choix Multiple',
        description: 'Sélectionnez une réponse correcte parmi les options données.',
      ),
      QuestionType(
        name: 'Sélection Multiple',
        description: 'Sélectionnez toutes les réponses correctes parmi les options données.',
      ),
      QuestionType(
        name: 'Réponse Textuelle',
        description: 'Tapez votre réponse dans le champ de texte fourni.',
      ),
      QuestionType(
        name: 'Vrai/Faux',
        description: 'Déterminez si l\'énoncé est vrai ou faux.',
      ),
      QuestionType(
        name: 'Calcul',
        description: 'Résolvez le problème donné et entrez la réponse numérique.',
      ),
      ],
      previousAttempts: [
        PreviousAttempt(
          date: '2023-06-05',
          score: 65,
          correct: 6,
          total: 10,
          timeSpent: 12,
        ),
      ],
      notes: 'Focus on understanding the core concepts and their practical applications.',
    );
  }
}