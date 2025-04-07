import 'annee_scolaire.dart';
import 'inscription.dart';

class Classe {
  int idClasse;
  String nom;
  AnneeScolaire? anneeScolaire;
  List<Inscription> inscriptions;

  Classe({
    required this.idClasse,
    required this.nom,
    this.anneeScolaire,
    this.inscriptions = const [],
  });

  factory Classe.fromJson(Map<String, dynamic> json) {
    List<Inscription> inscriptions = [];
    if (json['inscriptions'] != null) {
      inscriptions = List<Inscription>.from(
        json['inscriptions'].map((x) => Inscription.fromJson(x)),
      );
    }

    return Classe(
      idClasse: json['idClasse'],
      nom: json['nom'],
      anneeScolaire: json['anneeScolaire'] != null 
          ? AnneeScolaire.fromJson(json['anneeScolaire']) 
          : null,
      inscriptions: inscriptions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idClasse': idClasse,
      'nom': nom,
      'anneeScolaire': anneeScolaire?.toJson(),
      'inscriptions': inscriptions.map((x) => x.toJson()).toList(),
    };
  }
}