
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
      title: 'Chapter Evaluation',
      description: 'Test your understanding of the concepts covered in this chapter.',
      totalQuestions: 10,
      timeLimit: 15,
      passingScore: 70,
      maxAttempts: 3,
      instructions: [
        'Read each question carefully before answering.',
        'You can change your answers before submitting the quiz.',
        'Some questions may have multiple correct answers.',
        'You have 15 minutes to complete this quiz.',
        'You need 70% to pass this evaluation.'
      ],
      questionTypes: [
        QuestionType(
          name: 'Multiple Choice',
          description: 'Select one correct answer from the given options.',
        ),
        QuestionType(
          name: 'Multiple Select',
          description: 'Select all correct answers from the given options.',
        ),
        QuestionType(
          name: 'Text Answer',
          description: 'Type your answer in the provided text field.',
        ),
        QuestionType(
          name: 'Calculation',
          description: 'Solve the given problem and enter the numerical answer.',
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