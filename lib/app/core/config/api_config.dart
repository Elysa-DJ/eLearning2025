
class ApiConfig {
  // android addr 10.0.2.2
  static const String uri = 'https://c68d-2c0f-ef58-160d-dc00-82b-f0c0-bb72-ec4e.ngrok-free.app';
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
