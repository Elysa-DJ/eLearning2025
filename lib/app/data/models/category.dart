class Category {
  final int id;
  final String libelleCat;

  Category({
    required this.id,
    required this.libelleCat,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      libelleCat: json['libelle_cat'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'libelleCat': libelleCat,
    };
  }

   static List<Category> fromArrayJson(List<dynamic>jsonList){
    // ignore: unnecessary_cast
    return jsonList.map((e)=>Category.fromJson(e)).toList();
 }

static List<Map<String,dynamic>> toArrayJson(List<Category>jsonList){
    return jsonList.map((e)=>e.toJson()).toList();
 }
}
