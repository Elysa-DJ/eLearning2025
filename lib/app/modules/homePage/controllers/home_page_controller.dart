import 'package:get/get.dart';
import '../../../data/models/course.dart';

class HomePageController extends GetxController {
  final isLoading = true.obs;
  final latestCourses = <Course>[].obs;
  final popularCourses = <Course>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      latestCourses.value = [
        Course(
          idCours: '1',
          titre: 'Introduction au Développement Web',
          imageUrl: 'https://images.pexels.com/photos/1181671/pexels-photo-1181671.jpeg',
          rating: 4.5,
        ),
        Course(
          idCours: '2',
          titre: 'Design UI/UX Avancé',
          imageUrl: 'https://images.pexels.com/photos/196644/pexels-photo-196644.jpeg',
          rating: 4.8,
        ),
        Course(
          idCours: '3',
          titre: 'Marketing Digital',
          imageUrl: 'https://images.pexels.com/photos/905163/pexels-photo-905163.jpeg',
          rating: 4.2,
        ),
      ];

      popularCourses.value = [
        Course(
          idCours: '4',
          titre: 'React Native pour Débutants',
          imageUrl: 'https://images.pexels.com/photos/1181244/pexels-photo-1181244.jpeg',
          rating: 4.9,
        ),
        Course(
          idCours: '5',
          titre: 'Flutter Development',
          imageUrl: 'https://images.pexels.com/photos/1181298/pexels-photo-1181298.jpeg',
          rating: 4.7,
        ),
        Course(
          idCours: '6',
          titre: 'Swift UI Masterclass',
          imageUrl: 'https://images.pexels.com/photos/1181271/pexels-photo-1181271.jpeg',
          rating: 4.6,
        ),
      ];

      isLoading.value = false;
    } catch (e) {
      print('Error fetching courses: $e');
      isLoading.value = false;
    }
  }
}
