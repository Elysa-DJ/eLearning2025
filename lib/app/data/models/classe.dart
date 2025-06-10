class Classe {
  final int id;
  final String libelleCl;

  Classe({
    required this.id,
    required this.libelleCl,
  });

  factory Classe.fromJson(Map<String, dynamic> json) {
    return Classe(
      id: json['id'],
      libelleCl: json['libelle_Cl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'libelle_Cl': libelleCl,
    };
  }

  static List<Classe> fromArrayJson(List<dynamic>jsonList){
    // ignore: unnecessary_cast
    return jsonList.map((e)=>Classe.fromJson(e)).toList();
 }

static List<Map<String,dynamic>> toArrayJson(List<Classe>jsonList){
    return jsonList.map((e)=>e.toJson()).toList();
  }
}