import 'cours.dart';

class Video extends Cours {
  int idVideo;
  String url;
  int duree;

  Video({
    required super.idCours,
    required super.titre,
    required super.description,
    required this.idVideo,
    required this.url,
    required this.duree,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      idCours: json['idCours'],
      titre: json['titre'],
      description: json['description'],
      idVideo: json['idVideo'],
      url: json['url'],
      duree: json['duree'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'idCours': idCours,
      'titre': titre,
      'description': description,
      'idVideo': idVideo,
      'url': url,
      'duree': duree,
    };
  }
}