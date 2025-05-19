
class Evaluation {
  final String id;
  final String title;
  final String chapterId;
  final String courseId;
  final String description;
  final int totalQuestions;
  final int timeLimit;
  final int passingScore;
  final int maxAttempts;
  final List<String> instructions;
  final List<QuestionType> questionTypes;
  final List<PreviousAttempt>? previousAttempts;
  final String? notes;

  Evaluation({
    required this.id,
    required this.courseId,
    required this.chapterId,
    required this.title,
    required this.description,
    required this.totalQuestions,
    required this.timeLimit,
    required this.passingScore,
    required this.maxAttempts,
    required this.instructions,
    required this.questionTypes,
    this.previousAttempts,
    this.notes,
  });

  factory Evaluation.fromJson(Map<String, dynamic> json) {
    return Evaluation(
      id: json['id'],
      courseId: json['courseId'],
      chapterId: json['chapterId'],
      title: json['title'],
      description: json['description'],
      totalQuestions: json['totalQuestions'],
      timeLimit: json['timeLimit'],
      passingScore: json['passingScore'],
      maxAttempts: json['maxAttempts'],
      instructions: List<String>.from(json['instructions']),
      questionTypes: json['questionTypes'],
      previousAttempts: json['previousAttempts'] != null
          ? (json['previousAttempts'] as List)
              .map((attempt) => PreviousAttempt.fromJson(attempt))
              .toList()
          : null,
      notes: json['notes'],
    );
  }
}

class QuestionType {
  final String name;
  final String description;

  QuestionType({
    required this.name,
    required this.description,
  });

  factory QuestionType.fromJson(Map<String, dynamic> json) {
    return QuestionType(
      name: json['name'],
      description: json['description'],
    );
  }
}

class PreviousAttempt {
  final String date;
  final int score;
  final int correct;
  final int total;
  final int timeSpent;

  PreviousAttempt({
    required this.date,
    required this.score,
    required this.correct,
    required this.total,
    required this.timeSpent,
  });

  factory PreviousAttempt.fromJson(Map<String, dynamic> json) {
    return PreviousAttempt(
      date: json['date'],
      score: json['score'],
      correct: json['correct'],
      total: json['total'],
      timeSpent: json['timeSpent'],
    );
  }
}