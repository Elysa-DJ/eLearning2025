class Reponse {
  int idReponse;
  String reponse;
  bool estCorrecte;
  int idQuestion;

  Reponse({
    required this.idReponse,
    required this.reponse,
    required this.estCorrecte,
    required this.idQuestion,
  });

  factory Reponse.fromJson(Map<String, dynamic> json) {
    return Reponse(
      idReponse: json['idReponse'],
      reponse: json['reponse'],
      estCorrecte: json['estCorrecte'],
      idQuestion: json['idQuestion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idReponse': idReponse,
      'reponse': reponse,
      'estCorrecte': estCorrecte,
      'idQuestion': idQuestion,
    };
  }
}
