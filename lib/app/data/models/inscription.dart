

class Inscription {
  final int eleveId;
  final int coursId;


const Inscription ({
  required this.eleveId,
  required this.coursId

});

  factory Inscription.fromJson(Map<String, dynamic> json) {
    return Inscription(
      eleveId: json['eleve_id'],
      coursId: json['cours_id']
    );
}

  Map<String, dynamic> toJson() {
    return {
      'eleve_id': eleveId,
      'cours_id': coursId,
    };
  }

}