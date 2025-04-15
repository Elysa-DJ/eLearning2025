import 'reponse.dart';

class Question {
  int idQuestion;
  String question;
  int idEvaluation;
  List<Reponse> reponses;

  Question({
    required this.idQuestion,
    required this.question,
    required this.idEvaluation,
    this.reponses = const [],
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    List<Reponse> reponses = [];
    if (json['reponses'] != null) {
      reponses = List<Reponse>.from(
        json['reponses'].map((x) => Reponse.fromJson(x)),
      );
    }

    return Question(
      idQuestion: json['idQuestion'],
      question: json['question'],
      idEvaluation: json['idEvaluation'],
      reponses: reponses,
    );
  }

  Map<String, dynamic> toJson() => {
        'idQuestion': idQuestion,
        'question': question,
        'idEvaluation': idEvaluation,
        'reponses': reponses.map((x) => x.toJson()).toList(),
      };
}