import 'package:e_learning_app/app/data/models/pdf.dart';
import 'package:e_learning_app/app/data/models/video.dart';

abstract class Cours {
  int idCours;
  String titre;
  String description;

  Cours({
    required this.idCours,
    required this.titre,
    required this.description,
  });

  // Factory constructeur pour créer le bon type de cours
  factory Cours.fromJson(Map<String, dynamic> json) {
    // Vérifier le type de cours dans le JSON
    final String type = json['type'] ?? 'default';
    
    switch (type) {
      case 'pdf':
        return PDF.fromJson(json);
      case 'video':
        return Video.fromJson(json);
      default:
        return DefaultCours.fromJson(json);
    }
  }
  
  Map<String, dynamic> toJson() {
    return {
      'idCours': idCours,
      'titre': titre,
      'description': description,
    };
  }
}

// Une classe par défaut qui étend Cours
class DefaultCours extends Cours {
  DefaultCours({
    required int idCours,
    required String titre,
    required String description,
  }) : super(
          idCours: idCours,
          titre: titre,
          description: description,
        );

  factory DefaultCours.fromJson(Map<String, dynamic> json) {
    return DefaultCours(
      idCours: json['idCours'] ?? 0,
      titre: json['titre'] ?? '',
      description: json['description'] ?? '',
    );
  }
}