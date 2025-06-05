
class ApiConfig {
  // android addr 10.0.2.2
  static const String uri = 'https://d7de-2c0f-ef58-160d-dc00-1495-653e-2da0-1815.ngrok-free.app';
  static const String baseUrl = 
      '$uri/api/v1'; // À remplacer par votre URL d'API

  // Endpoints
  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static const String currentUser = 'auth/me';
  static const String refreshToken = 'auth/refresh-token';
  static const String profile = 'auth/profile';


  static const String posts = 'posts';
  static const String categories = 'categories';
}
