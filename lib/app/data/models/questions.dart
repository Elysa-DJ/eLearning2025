

class Question {
  final int id;
  final String text;
  final String name;
  final String description;
  //Type de question: Multiple Choice ou True/False calcule ou autre
  final String type;
  final String answers;
  final List<String>? options;
  final int correctAnswerId;

  Question({
    required this.id,
    required this.options,
    required this.text,
    required this.name,
    required this.description,
    required this.type,
    required this.answers,
    required this.correctAnswerId,
  });

  fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      options: json['options'],
      text: json['text'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      answers: json['answers'],
      correctAnswerId: json['correctAnswerId'],
    );
  }

  Map<String, dynamic>toJson() {
    return {
      'id': id,
      'text': text,
      'type': type,
      'options': options,
      'answers': answers,
      'correctAnswerId': correctAnswerId,
    };
  }
}






