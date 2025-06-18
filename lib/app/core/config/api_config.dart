
class ApiConfig {
  // android addr 10.0.2.2
  static const String uri = 'https://29dd-2c0f-ef58-160d-dc00-c8e2-12e-3677-63a3.ngrok-free.app';
  static const String baseUrl = 
      '$uri/api/v1'; // À remplacer par votre URL d'API

  // Endpoints
  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static const String currentUser = 'auth/me';
  static const String refreshToken = 'auth/refresh-token';
  static const String profile = 'auth/profile';
  static const String logout = 'auth/logout';
  static const String me = 'auth/me';
  static const String fetchInscription = 'auth/cours/inscription';
  static const String toggleEnrollment = 'auth/cours/toggle-enrollment';


  static const String posts = 'posts';

  //Resources

  static const String fetchCategories = 'categories/all';
  static const String fetchCycles = 'cycles/all';
  static const String fetchPopularCours = 'cours/all/popular';
  static const String fetchLatestCours = 'cours/all/latest';
}
