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

  Map<String, dynamic> toJson();
  
  factory Cours.fromJson(Map<String, dynamic> json, String type) {
    switch (type) {
      case 'pdf':
        return PDF.fromJson(json);
      case 'video':
        return Video.fromJson(json);
      default:
        throw Exception('Type de cours inconnu: $type');
    }
  }
}
