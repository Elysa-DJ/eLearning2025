import 'package:learning_app/app/data/models/classe.dart';

class Cycle {
  final int id;
  final String libelleC;
  final List<Classe> classes;

  Cycle(
    {
      required this.id,
    required this.libelleC,
    required this.classes,
    });

  factory Cycle.fromJson(Map<String, dynamic> json) {
    return Cycle(
      id: json['id'],
      libelleC: json['libelle_C'],
      classes: Classe.fromArrayJson(json['classes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'libelle_C': libelleC,
      'classes': Classe.toArrayJson(classes),
    };
  }

  static List<Cycle> fromArrayJson(List<dynamic>jsonList){
    // ignore: unnecessary_cast
    return jsonList.map((e)=>Cycle.fromJson(e)).toList();
 }

static List<Map<String,dynamic>> toArrayJson(List<Cycle>jsonList){
    return jsonList.map((e)=>e.toJson()).toList();
 }
}

