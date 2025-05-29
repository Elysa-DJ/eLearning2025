// class RegistrationData {
//   final String name;
//   final String? email;
//   final String password;
//   final String nom;
//   final String prenom;
//   final String dateN;
//   final String lieuN;
//   final String sexe;
//   final String nationalite;
//   final String villeResidence;
//   final String telephone;
//   final int classeId;
//   final int cycleId;

//   RegistrationData({
//     required this.name,
//     this.email,
//     required this.password,
//     required this.nom,
//     required this.prenom,
//     required this.dateN,
//     required this.lieuN,
//     required this.sexe,
//     required this.nationalite,
//     required this.villeResidence,
//     required this.telephone,
//     required this.classeId,
//     required this.cycleId,
//   });

//   Map toJson() {
//     final data = {
//       'name': name,
//       'password': password,
//       'nom': nom,
//       'prenom': prenom,
//       'date_N': dateN,
//       'lieu_N': lieuN,
//       'sexe': sexe,
//       'nationalite': nationalite,
//       'ville_residence': villeResidence,
//       'telephone': telephone,
//       'classe_id': classeId,
//       'cycle_id': cycleId,
//     };
    
//     return data;
    
//   }
// }


class RegisterRequest {
  final String name;
  final String? email;
  final String password;
  final String passwordConfirmation;

  final String nom;
  final String prenom;
  final String dateN;
  final String lieuN;
  final String sexe;
  final String nationalite;
  final String villeResidence;
  final String telephone;

  final int classeId;
  final int cycleId;

  RegisterRequest({
    required this.name,
    this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.nom,
    required this.prenom,
    required this.dateN,
    required this.lieuN,
    required this.sexe,
    required this.nationalite,
    required this.villeResidence,
    required this.telephone,
    required this.classeId,
    required this.cycleId,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "nom": nom,
        "prenom": prenom,
        "date_N": dateN,
        "lieu_N": lieuN,
        "sexe": sexe,
        "nationalite": nationalite,
        "ville_residence": villeResidence,
        "telephone": telephone,
        "classe_id": classeId,
        "cycle_id": cycleId,
      };
}
