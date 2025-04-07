import 'cours.dart';
import 'eleve.dart';

class Resultats {
  int idResultats;
  String details;
  Cours? cours;
  Eleve? eleve;

  Resultats({
    required this.idResultats,
    required this.details,
    this.cours,
    this.eleve,
  });

  factory Resultats.fromJson(Map<String, dynamic> json) {
    return Resultats(
      idResultats: json['idResultats'],
      details: json['details'],
      cours: json['cours'] != null 
          ? Cours.fromJson(json['cours'], json['typeCours']) 
          : null,
      eleve: json['eleve'] != null ? Eleve.fromJson(json['eleve']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idResultats': idResultats,
      'details': details,
      'cours': cours?.toJson(),
      'eleve': eleve?.toJson(),
    };
  }
}