// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/config/api_config.dart';
import '../../../data/models/course.dart';
import '../../../data/models/inscription.dart';
import '../../../data/services/api_service.dart';

class CourseDetailsController extends GetxController {

    final Rx<Cours> _cours = Get.arguments['cours'];
    
    final isEnrolling = false.obs;
    final isEnrolled = false.obs;
    final _apiService = Get.find<ApiService>();
    
    Cours get cours => _cours.value; 

  
  @override
  void onInit() async{
    super.onInit();
    fetchInscription();
    
  }
  Future<void> enrollInCourse(coursID) async {
    try {
      isEnrolling.value = true;
      
      final response = _apiService.post(ApiConfig.toggleEnrollment,{
        'cours_id':coursID
      }, (data)=>data);

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

  void unenrollFromCourse() {
    isEnrolled.value = false;
    
    Get.snackbar(
      'Désinscription',
      'Vous vous êtes désinscrit du cours',
      backgroundColor: const Color.fromARGB(255, 42, 7, 5),
      colorText: Colors.white,
    );
  }

  void startChapterEvaluation(int index) {
    // Implement evaluation logic here
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

  Future<void> fetchInscription() async {
    try {
      // Récupère l'inscription
    final inscription = await _apiService.get<Inscription>(
      ApiConfig.fetchInscription,
      (data) => Inscription.fromJson(data['data']),
    );

    // Ensuite, on récupère le cours à partir de son ID
    // final cours = await _apiService.get<Cours>(
    //   '${ApiConfig.fetchCours}/${inscription.coursId}',
    //   (data) => Cours.fromJson(data['data']),
    // );

    _cours.value = cours;
    } catch (e) {
      print('Error fetching inscription: $e');
    }
  }

  
  
}

