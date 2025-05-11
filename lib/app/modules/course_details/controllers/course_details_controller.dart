// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;

import '../../../data/models/course.dart';

class CourseDetailsController extends GetxController {
  // final pdfPath = Rx<String?>(null);
  // final pdfUrl = Rx<String?>(null);
  // final isLoadingPdf = false.obs;
  // final urlPdfController = TextEditingController();
  // final pdfViewerKey = GlobalKey<SfPdfViewerState>();
   final Course course;
  final isEnrolling = false.obs;
  final isEnrolled = false.obs;

  CourseDetailsController({required this.course});
  //  void onClose() {
  //   urlPdfController.dispose();
  //   super.onClose();
  // }

  Future<void> enrollInCourse() async {
    try {
      isEnrolling.value = true;
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
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
        backgroundColor: Colors.red,
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
      backgroundColor: Colors.red,
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

  // Méthodes pour le PDF
  // Future<void> pickPDFFile() async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['pdf'],
  //     );

  //     if (result != null) {
  //       pdfPath.value = result.files.single.path;
  //       pdfUrl.value = null;
  //     }
  //   } catch (e) {
  //     _showErrorDialog('Erreur lors de la sélection du fichier: $e');
  //   }
  // }

  // Future<void> loadPDFFromUrl() async {
  //   if (urlPdfController.text.isEmpty) {
  //     _showErrorDialog('Veuillez entrer une URL valide');
  //     return;
  //   }

  //   final url = urlPdfController.text.trim();
  //   if (!url.toLowerCase().endsWith('.pdf')) {
  //     _showErrorDialog("L'URL doit pointer vers un fichier PDF");
  //     return;
  //   }

  //   isLoadingPdf.value = true;

  //   try {
  //     final response = await http.get(Uri.parse(url));
      
  //     if (response.statusCode == 200) {
  //       final appDir = await getTemporaryDirectory();
  //       final file = File('${appDir.path}/downloaded.pdf');
  //       await file.writeAsBytes(response.bodyBytes);
        
  //       pdfPath.value = file.path;
  //       pdfUrl.value = url;
  //       isLoadingPdf.value = false;
  //     } else {
  //       isLoadingPdf.value = false;
  //       _showErrorDialog('Impossible de télécharger le PDF: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     isLoadingPdf.value = false;
  //     _showErrorDialog('Erreur lors du téléchargement: $e');
  //   }
  // }

  // // void reloadPdf() {
  // //   pdfViewerKey.currentState?.reload();
  // // }

  // void _showErrorDialog(String message) {
  //   Get.dialog(
  //     AlertDialog(
  //       title: const Text('Erreur'),
  //       content: Text(message),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Get.back(),
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
