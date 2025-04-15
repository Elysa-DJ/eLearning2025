import 'cours.dart';
import 'pdf.dart';
import 'video.dart';
import 'eleve.dart';

class Resultats {
  int idResultats;
  String details;
  Cours? cours;
  Eleve? eleve;

  Resultats({
    required this.idResultats,
    required this.details,
    this.cours,
    this.eleve,
  });

  factory Resultats.fromJson(Map<String, dynamic> json) {
    return Resultats(
      idResultats: json['idResultats'] ?? 0,
      details: json['details'] ?? '',
      cours: json['cours'] != null 
          ? Cours.fromJson({
              ...json['cours'] as Map<String, dynamic>,
              'type': json['typeCours'] ?? 'default' // Ajout du type dans le même objet
            })
          : null,
      eleve: json['eleve'] != null ? Eleve.fromJson(json['eleve']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'idResultats': idResultats,
      'details': details,
    };
    
    if (cours != null) {
      data['cours'] = cours!.toJson();
      // Si le cours est de type PDF ou Video, on récupère son type
      if (cours is PDF) {
        data['typeCours'] = 'pdf';
      } else if (cours is Video) {
        data['typeCours'] = 'video';
      } else {
        data['typeCours'] = 'default';
      }
    }
    
    if (eleve != null) {
      data['eleve'] = eleve!.toJson();
    }
    
    return data;
  }
}