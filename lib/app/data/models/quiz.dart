enum QuestionType {
  multipleChoice,
  multipleSelect,
  text,
  calculation
}

class Quiz {
  final String id;
  final String courseId;
  final String chapterId;
  final String title;
  final String description;
  final int timeLimit;
  final int passingScore;
  final List<Question> questions;

  Quiz({
    required this.id,
    required this.courseId,
    required this.chapterId,
    required this.title,
    required this.description,
    required this.timeLimit,
    required this.passingScore,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      courseId: json['courseId'],
      chapterId: json['chapterId'],
      title: json['title'],
      description: json['description'],
      timeLimit: json['timeLimit'],
      passingScore: json['passingScore'],
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
    );
  }
}

class Question {
  final String id;
  final QuestionType type;
  final String text;
  final String? image;
  final List<Option>? options;
  final bool? multiline;
  final String? formula;
  final String? unit;

  Question({
    required this.id,
    required this.type,
    required this.text,
    this.image,
    this.options,
    this.multiline,
    this.formula,
    this.unit,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      type: QuestionType.values.firstWhere(
        (t) => t.toString() == 'QuestionType.${json['type']}',
      ),
      text: json['text'],
      image: json['image'],
      options: json['options'] != null
          ? (json['options'] as List).map((o) => Option.fromJson(o)).toList()
          : null,
      multiline: json['multiline'],
      formula: json['formula'],
      unit: json['unit'],
    );
  }
}

class Option {
  final String id;
  final String text;

  Option({
    required this.id,
    required this.text,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      text: json['text'],
    );
  }
}

class QuizSubmission {
  final String id;
  final String quizId;
  final String userId;
  final int score;
  final int timeSpent;
  final int correctCount;
  final int incorrectCount;
  final int unansweredCount;
  final Map<String, dynamic> correctAnswers;
  final Map<String, dynamic> userAnswers;
  final String feedback;

  QuizSubmission({
    required this.id,
    required this.quizId,
    required this.userId,
    required this.score,
    required this.timeSpent,
    required this.correctCount,
    required this.incorrectCount,
    required this.unansweredCount,
    required this.correctAnswers,
    required this.userAnswers,
    required this.feedback,
  });

  factory QuizSubmission.fromJson(Map<String, dynamic> json) {
    return QuizSubmission(
      id: json['id'],
      quizId: json['quizId'],
      userId: json['userId'],
      score: json['score'],
      timeSpent: json['timeSpent'],
      correctCount: json['correctCount'],
      incorrectCount: json['incorrectCount'],
      unansweredCount: json['unansweredCount'],
      correctAnswers: json['correctAnswers'],
      userAnswers: json['userAnswers'],
      feedback: json['feedback'],
    );
  }
}