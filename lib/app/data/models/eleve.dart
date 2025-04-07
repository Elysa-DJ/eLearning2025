import 'utilisateur.dart';

class Eleve extends Utilisateur {
  int idEleve;
  String dateNaissance;
  String? telephone;
  String niveau;

  Eleve({
    required super.idUtilisateur,
    required super.nom,
    required super.prenom,
    required super.email,
    required super.motDePasse,
    required this.idEleve,
    required this.dateNaissance,
    this.telephone,
    required this.niveau,
  });

  factory Eleve.fromJson(Map<String, dynamic> json) {
    return Eleve(
      idUtilisateur: json['idUtilisateur'],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      motDePasse: json['motDePasse'],
      idEleve: json['idEleve'],
      dateNaissance: json['dateNaissance'],
      telephone: json['telephone'],
      niveau: json['niveau'],
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
      'idEleve': idEleve,
      'dateNaissance': dateNaissance,
      'telephone': telephone,
      'niveau': niveau,
    };
  }
}