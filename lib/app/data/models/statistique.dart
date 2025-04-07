import 'utilisateur.dart';

class Statistiques {
  int idStatistiques;
  String donnees;
  Utilisateur? utilisateur;

  Statistiques({
    required this.idStatistiques,
    required this.donnees,
    this.utilisateur,
  });

  factory Statistiques.fromJson(Map<String, dynamic> json) {
    return Statistiques(
      idStatistiques: json['idStatistiques'],
      donnees: json['donnees'],
      utilisateur: json['utilisateur'] != null && json['typeUtilisateur'] != null
          ? Utilisateur.fromJson(json['utilisateur'], json['typeUtilisateur'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idStatistiques': idStatistiques,
      'donnees': donnees,
      'utilisateur': utilisateur?.toJson(),
    };
  }
}