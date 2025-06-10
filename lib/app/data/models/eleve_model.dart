import 'package:learning_app/app/data/models/annee_scolaire.dart';
import 'package:learning_app/app/data/models/info_perso.dart';
import 'package:learning_app/app/data/models/user.dart';

class Eleve{
  final int id;
  final String matricule;
  final InfoPerso person;
  final String cycle;
  final String  classe;
  final User compte;
  final AnneeScolaire anneeScolaire;

  Eleve({
    required this.id,
    required this.matricule,
    required this.person,
    required this.cycle,
    required this.classe,
    required this.compte,
    required this.anneeScolaire,
  });

  factory Eleve.fromJson(Map<String, dynamic> json) {
    return Eleve(
      id: json['id'],
      matricule: json['matricule'],
      person: InfoPerso.fromJson(json['person']),
      cycle: json['cycle'],
      classe: json['classe'],
      compte: User.fromJson(json['compte']),
      anneeScolaire: json['anneeScolaire'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'matricule': matricule,
      'person': person.toJson(),
      'cycle': cycle,
      'classe': classe,
      'compte': compte.toJson(),
      'anneeScolaire': anneeScolaire.toJson(),
    };

  }

}