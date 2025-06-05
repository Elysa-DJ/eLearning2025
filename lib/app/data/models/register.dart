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
  final String surname;
  final String dateOfBirth;
  final String city;
  final String email;
  final String username;
  final String password;
  final String? phone;
  final String cycle;
  final String className; // ou 'class' selon votre API

  RegisterRequest({
    required this.name,
    required this.surname,
    required this.dateOfBirth,
    required this.city,
    required this.email,
    required this.username,
    required this.password,
    this.phone,
    required this.cycle,
    required this.className,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'dateOfBirth': dateOfBirth,
      'city': city,
      'email': email,
      'username': username,
      'password': password,
      if (phone != null) 'phone': phone,
      'cycle': cycle,
      'class': className, // Vérifiez le nom attendu par votre API
    };
  }
}
