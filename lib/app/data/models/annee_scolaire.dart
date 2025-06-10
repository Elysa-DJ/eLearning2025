class AnneeScolaire {
  final int id;
  final String libelleA;

  AnneeScolaire({
    required this.id,
    required this.libelleA,
  });

  factory AnneeScolaire.fromJson(Map<String, dynamic> json) {
    return AnneeScolaire(
      id: json['id'],
      libelleA: json['libelleA'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'libelleA': libelleA,
    };
  }
}