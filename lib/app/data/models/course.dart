import 'package:learning_app/app/data/models/category.dart';
import 'package:learning_app/app/data/models/inscription.dart';

class Cours{
  final int id;
  final String titre;
  final String matiere;
  final String? imageUrl;
  final String prof;
  final String description;
  final List<Category> categories;
  final List<Chapter>? chapters;
  final Inscription? inscription;
  
  int get duration {
    if (chapters == null) return 0;
    return chapters!.fold(0, (sum, chapter) => sum + chapter.learningTime);
  }

  Cours({
    required this.id,
    required this.titre,
    required this.matiere,
    this.imageUrl,
    required this.prof,
    required this.description,
    this.categories = const [],
    this.chapters,
    this.inscription
  });

  factory Cours.fromJson(Map<String, dynamic> json) {
    return Cours(
      id: json['id'],
      titre: json['titre'],
      // Fix: Extract the name from matiere object or use empty string
      matiere: json['matiere'] != null 
          ? (json['matiere'] is String 
              ? json['matiere'] 
              : json['matiere']['nom'] ?? json['matiere']['name'] ?? '')
          : '',
      imageUrl: json['imageUrl'],
      // Fix: Extract the name from prof object or use empty string  
      prof: json['prof'] != null
          ? (json['prof'] is String
              ? json['prof']
              : json['prof']['nom'] ?? json['prof']['name'] ?? json['prof']['prenom'] ?? '')
          : '',
      description: json['description'] ?? '',
      inscription: json['inscription'] != null 
          ? Inscription.fromJson(json['inscription']) 
          : null
  
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titre': titre,
      'matiere': matiere,
      'imageUrl': imageUrl,
      'prof': prof,
      'description': description,
      'inscription': inscription,
    };
  }
static List<Cours> fromArrayJson(List<dynamic>jsonList){
    // ignore: unnecessary_cast
    return jsonList.map((e)=>Cours.fromJson(e)).toList();
 }

static List<Map<String,dynamic>> toArrayJson(List<Cours>jsonList){
    return jsonList.map((e)=>e.toJson()).toList();
 }
}



class Course {
  final String idCours;
  final String titre;
  final String? imageUrl;
  final double? rating;
  final String? description;
  final String? instructor;
  final List<String> categories;
  final int? students;
  final double? price;
  final List<Chapter>? chapters;

  // Calculate total course duration based on chapters' learning time
  int get duration {
    if (chapters == null) return 0;
    return chapters!.fold(0, (sum, chapter) => sum + chapter.learningTime);
  }

  

  Course({
    required this.idCours,
    required this.titre,
    this.imageUrl,
    this.rating,
    this.description,
    this.instructor,
    this.categories = const [],
    this.students,
    this.price,
    this.chapters,
  });
}

class Chapter {
  final String id;
  final String title;
  final String description;
  final List<Section> sections;
  final int learningTime; // in minutes

  Chapter({
    required this.id,
    required this.title,
    required this.description,
    this.sections = const [],
    required this.learningTime,
  });
}

class Section {
  final String title;
  final String description;
  final String? videoUrl;
  final String? pdfUrl;

  Section({
    required this.title,
    required this.description,
    this.videoUrl,
    this.pdfUrl,
  });
}