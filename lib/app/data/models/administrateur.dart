import 'utilisateur.dart';

class Administrateur extends Utilisateur {
  int idAdministrateur;
  String role;

  Administrateur({
    required super.idUtilisateur,
    required super.nom,
    required super.prenom,
    required super.email,
    required super.motDePasse,
    required this.idAdministrateur,
    required this.role,
  });

  factory Administrateur.fromJson(Map<String, dynamic> json) {
    return Administrateur(
      idUtilisateur: json['idUtilisateur'],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      motDePasse: json['motDePasse'],
      idAdministrateur: json['idAdministrateur'],
      role: json['role'],
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
      'idAdministrateur': idAdministrateur,
      'role': role,
    };
  }
}
