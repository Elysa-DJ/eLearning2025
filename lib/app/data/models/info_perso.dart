class InfoPerso {
  final int id;
  final String nom;
  final String prenom;
  final String dateNaissance;
  final String lieuNaissance;
  final String adresse;
  final String sexe;
  final String ville;
  final String nationnalite;
  final String telephone;

  InfoPerso({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.dateNaissance,
    required this.lieuNaissance,
    required this.adresse,
    required this.sexe,
    required this.ville,
    required this.nationnalite,
    required this.telephone,
  });

  factory InfoPerso.fromJson(Map<String, dynamic> json) {
    return InfoPerso(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      dateNaissance: json['dateNaissance'],
      lieuNaissance: json['lieuNaissance'],
      adresse: json['adresse'],
      sexe: json['sexe'],
      ville: json['ville'],
      nationnalite: json['nationnalite'],
      telephone: json['telephone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'dateNaissance': dateNaissance,
      'lieuNaissance': lieuNaissance,
      'adresse': adresse,
      'sexe': sexe,
      'ville': ville,
      'nationnalite': nationnalite,
      'telephone': telephone,
    };
  }
  
}