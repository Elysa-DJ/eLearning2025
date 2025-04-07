class Cycle {
  int idCycle;
  String nom;

  Cycle({
    required this.idCycle,
    required this.nom,
  });

  factory Cycle.fromJson(Map<String, dynamic> json) {
    return Cycle(
      idCycle: json['idCycle'],
      nom: json['nom'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCycle': idCycle,
      'nom': nom,
    };
  }
}