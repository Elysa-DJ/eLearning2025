import 'cours.dart';

class PDF extends Cours {
  int idPDF;
  String chemin;

  PDF({
    required super.idCours,
    required super.titre,
    required super.description,
    required this.idPDF,
    required this.chemin,
  });

  factory PDF.fromJson(Map<String, dynamic> json) {
    return PDF(
      idCours: json['idCours'],
      titre: json['titre'],
      description: json['description'],
      idPDF: json['idPDF'],
      chemin: json['chemin'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'idCours': idCours,
      'titre': titre,
      'description': description,
      'idPDF': idPDF,
      'chemin': chemin,
    };
  }
}