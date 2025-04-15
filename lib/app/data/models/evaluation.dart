import 'administrateur.dart';
import 'cours.dart';
import 'question.dart';

class Evaluation {
  int idEvaluation;
  double note;
  DateTime dateEvaluation;
  List<Question> questions;
  Cours? cours;
  Administrateur? administrateur;

  Evaluation({
    required this.idEvaluation,
    required this.note,
    required this.dateEvaluation,
    this.questions = const [],
    this.cours,
    this.administrateur,
  });

  factory Evaluation.fromJson(Map<String, dynamic> json) {
    List<Question> questionsList = [];
    if (json['questions'] != null) {
      questionsList = List<Question>.from(
        json['questions'].map((x) => Question.fromJson(x)),
      );
    }

    return Evaluation(
      idEvaluation: json['idEvaluation'],
      note: json['note'].toDouble(),
      dateEvaluation: DateTime.parse(json['dateEvaluation']),
      questions: questionsList,
      cours: json['cours'] != null
          ? Cours.fromJson(json['cours'])
          : null,
      administrateur: json['administrateur'] != null
          ? Administrateur.fromJson(json['administrateur'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idEvaluation': idEvaluation,
      'note': note,
      'dateEvaluation': dateEvaluation.toIso8601String(),
      'questions': questions.map((x) => x.toJson()).toList(),
      'cours': cours?.toJson(),
      'administrateur': administrateur?.toJson(),
    };
  }
}