import 'utilisateur.dart';

class Enseignant extends Utilisateur {
  int idEnseignant;
  String specialite;

  Enseignant({
    required super.idUtilisateur,
    required super.nom,
    required super.prenom,
    required super.email,
    required super.motDePasse,
    required this.idEnseignant,
    required this.specialite,
  });

  factory Enseignant.fromJson(Map<String, dynamic> json) {
    return Enseignant(
      idUtilisateur: json['idUtilisateur'],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      motDePasse: json['motDePasse'],
      idEnseignant: json['idEnseignant'],
      specialite: json['specialite'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'idUtilisateur': idUtilisateur,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'motDePasse': motDePasse,
      'idEnseignant': idEnseignant,
      'specialite': specialite,
    };
  }
}