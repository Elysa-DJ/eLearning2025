import 'package:e_learning_app/app/data/models/administrateur.dart';
import 'package:e_learning_app/app/data/models/eleve.dart';
import 'package:e_learning_app/app/data/models/enseignant.dart';

abstract class Utilisateur {
  int ? idUtilisateur;
  String nom;
  String ?prenom;
  String? email;
  String? motDePasse;

  Utilisateur({
   this.idUtilisateur,
    required this.nom,
     this.prenom,
     this.email,
    this.motDePasse,
  });

  Map<String, dynamic> toJson();
  
  factory Utilisateur.fromJson(Map<String, dynamic> json, String type) {
    switch (type) {
      case 'eleve':
        return Eleve.fromJson(json);
      case 'enseignant':
        return Enseignant.fromJson(json);
      case 'administrateur':
        return Administrateur.fromJson(json);
      default:
        throw Exception('Type d\'utilisateur inconnu: $type');
    }
  }
}