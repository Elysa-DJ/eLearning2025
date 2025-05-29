
class ApiConfig {
  // android addr 10.0.2.2
  static const String uri = 'https://ad5e-102-141-41-115.ngrok-free.app';
  static const String baseUrl = 
      '$uri/api/v1'; // À remplacer par votre URL d'API

  // Endpoints
  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static const String currentUser = 'auth/me';
  static const String refreshToken = 'auth/refresh-token';


  static const String posts = 'posts';
  static const String categories = 'categories';
}
