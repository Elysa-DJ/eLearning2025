import 'classe.dart';
import 'eleve.dart';

class Inscription {
  int idInscription;
  DateTime dateInscription;
  Eleve? eleve;
  Classe? classe;

  Inscription({
    required this.idInscription,
    required this.dateInscription,
    this.eleve,
    this.classe,
  });

  factory Inscription.fromJson(Map<String, dynamic> json) {
    return Inscription(
      idInscription: json['idInscription'],
      dateInscription: DateTime.parse(json['dateInscription']),
      eleve: json['eleve'] != null ? Eleve.fromJson(json['eleve']) : null,
      classe: json['classe'] != null ? Classe.fromJson(json['classe']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idInscription': idInscription,
      'dateInscription': dateInscription.toIso8601String(),
      'eleve': eleve?.toJson(),
      'classe': classe?.toJson(),
    };
  }
}