import 'utilisateur.dart';

class Notification {
  int idNotification;
  String message;
  DateTime dateNotification;
  Utilisateur? utilisateur;

  Notification({
    required this.idNotification,
    required this.message,
    required this.dateNotification,
    this.utilisateur,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      idNotification: json['idNotification'],
      message: json['message'],
      dateNotification: DateTime.parse(json['dateNotification']),
      utilisateur: json['utilisateur'] != null && json['typeUtilisateur'] != null
          ? Utilisateur.fromJson(json['utilisateur'], json['typeUtilisateur'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idNotification': idNotification,
      'message': message,
      'dateNotification': dateNotification.toIso8601String(),
      'utilisateur': utilisateur?.toJson(),
    };
  }
}