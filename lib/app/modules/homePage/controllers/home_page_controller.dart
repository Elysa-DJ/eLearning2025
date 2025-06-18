import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/api_config.dart';
import '../../../data/models/category.dart';
import '../../../data/models/course.dart';
import '../../../data/models/inscription.dart';
import '../../../data/models/user.dart';
import '../../../data/services/api_service.dart';
import '../../../routes/app_pages.dart';

class HomePageController extends GetxController {
  final isLoading = true.obs;
  final isLatestCoursLoading = true.obs;
  final isEnrolling = false.obs;
  final isEnrolled = false.obs;
  final latestCourses = <Cours>[].obs;
  final popularCourses = <Cours>[].obs;
  final _apiService = Get.find<ApiService>();
  final _currentUser = Rx<User?>(null);
  final Rx<List> categories = Rx<List>([]);

  User? get currentUser => _currentUser.value;  

  @override
  void onInit() async {
    super.onInit();
    await initializeData();
  }

  // ✅ Méthode d'initialisation centralisée
  Future<void> initializeData() async {
    await Future.wait([
      fetchCourses(),
      fetchLatestCourses(), // ← Ajouté ici
      fetchCategories(),
    ]);
    
    if (_apiService.isAuthenticated) {
      await me();
    }
  }

  Future<void> fetchCourses() async {
    try {
      isLoading.value = true;
      final response = await _apiService.get<List<Cours>>(
        ApiConfig.fetchPopularCours,
        (data) => Cours.fromArrayJson(data['data']),
      );

      popularCourses.value = response;
      popularCourses.refresh();
    } catch (e) {
      print('Error fetching courses: $e');
      Get.snackbar(
        'Erreur',
        'Impossible de charger les cours populaires',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ✅ CORRECTION: Uniformisation avec fetchCourses()
  Future<void> fetchLatestCourses() async {
    try {
      isLatestCoursLoading.value = true;
      final response = await _apiService.get<List<Cours>>(
        ApiConfig.fetchLatestCours,
        (data) => Cours.fromArrayJson(data['data']), // ← Correction ici
      );

      latestCourses.value = response;
      latestCourses.refresh();
    } catch (e) {
      print('Error fetching latest courses: $e');
      Get.snackbar(
        'Erreur',
        'Impossible de charger les derniers cours',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLatestCoursLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        ApiConfig.logout, 
        (data) => data as Map<String, dynamic>
      );
      Get.snackbar('Déconnexion', response['message']);
      await _apiService.logout();
      Get.offAllNamed(Routes.ONBOARDING2);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      Get.offAllNamed(Routes.ONBOARDING2);
    }
  }

  Future<void> me() async {
    try {
      final response = await _apiService.get<User>(
        ApiConfig.me, 
        (data) => User.fromJson(data['data'])
      );
      _currentUser.value = response;
      print('Current user: ${_currentUser.value!.toJson()}');
      _currentUser.refresh();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> fetchCategories() async {
    try {
      final response = await _apiService.get<List<Category>>(
        ApiConfig.fetchCategories,
        (data) => Category.fromArrayJson(data['data']),
      );
      categories.value = response;
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  // ✅ CORRECTION: Méthodes wrapper synchrones pour les boutons
  void handleEnrollInCourse(int coursId) {
    enrollInCourse(coursId);
  }

  void handleUnenrollFromCourse() {
    unenrollFromCourse();
  }

  // ✅ CORRECTION: Ajout du coursId manquant et await
  Future<void> enrollInCourse(int coursId) async {
    try {
      isEnrolling.value = true;
      
      final response = await _apiService.post(
        ApiConfig.toggleEnrollment,
        {'cours_id': coursId},
        (data) => data
      );
      
      isEnrolled.value = true;
      Get.snackbar(
        'Succès',
        'Inscription au cours réussie !',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Une erreur est survenue lors de l\'inscription',
        backgroundColor: const Color.fromARGB(255, 49, 7, 4),
        colorText: Colors.white,
      );
    } finally {
      isEnrolling.value = false;
    }
  }

  Future<void> unenrollFromCourse() async {
    try {
      isEnrolling.value = true;
      
      // ✅ TODO: Ajoutez l'appel API réel pour la désinscription
      // await _apiService.post(ApiConfig.toggleEnrollment, {'cours_id': coursId}, (data) => data);
      
      isEnrolled.value = false;
      
      Get.snackbar(
        'Désinscription',
        'Vous vous êtes désinscrit du cours',
        backgroundColor: const Color.fromARGB(255, 42, 7, 5),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Erreur lors de la désinscription',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isEnrolling.value = false;
    }
  }

  void startChapterEvaluation(int index) {
    Get.snackbar(
      'Évaluation',
      'Démarrage de l\'évaluation pour le chapitre ${index + 1}',
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  bool isChapterLocked(int index) {
    return !isEnrolled.value;
  }

  String formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return '${hours}h ${remainingMinutes}min';
  }

  // ✅ CORRECTION: Ajout du coursId en paramètre
  Future<void> fetchInscription(int coursId) async {
    try {
      final inscription = await _apiService.post(
        ApiConfig.fetchInscription,
        {'cours_id': coursId},
        (data) => Inscription.fromJson(data['data']),
      );

      final cours = await _apiService.get<Cours>(
        '${ApiConfig.fetchPopularCours}/${inscription.coursId}',
        (data) => Cours.fromJson(data['data']),
      );
    } catch (e) {
      print('Error fetching inscription: $e');
    }
  }

  // ✅ Méthode pour rafraîchir toutes les données
  Future<void> refreshData() async {
    await initializeData();
  }
}