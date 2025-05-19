import 'questions.dart';

class Quizz {
  final int id;
  final String title;
  final int timeLimit;
  final int passingScore;
  final List<Question> questions;

  Quizz({
    required this.id,
    required this.title,
    required this.timeLimit,
    required this.passingScore,
    required this.questions,
  });

  fromJson (Map<String, dynamic> json) {
    return Quizz(
      id: json['id'],
      title: json['title'],
      timeLimit: json['time_limit'],
      passingScore: json['passing_score'],
      questions: json['questions'],
    );
  }

  toJson() {
    return {
      'id': id,
      'title': title,
      'time_limit': timeLimit,
      'passing_score': passingScore,
      'questions': questions,
    };
  }
}

