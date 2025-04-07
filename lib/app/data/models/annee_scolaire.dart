import 'cycle.dart';

class AnneeScolaire {
  int idAnneeScolaire;
  int anneeDebut;
  int anneeFin;
  Cycle? cycle;

  AnneeScolaire({
    required this.idAnneeScolaire,
    required this.anneeDebut,
    required this.anneeFin,
    this.cycle,
  });

  factory AnneeScolaire.fromJson(Map<String, dynamic> json) {
    return AnneeScolaire(
      idAnneeScolaire: json['idAnneeScolaire'],
      anneeDebut: json['anneeDebut'],
      anneeFin: json['anneeFin'],
      cycle: json['cycle'] != null ? Cycle.fromJson(json['cycle']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idAnneeScolaire': idAnneeScolaire,
      'anneeDebut': anneeDebut,
      'anneeFin': anneeFin,
      'cycle': cycle?.toJson(),
    };
  }
}