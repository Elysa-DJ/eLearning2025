import 'package:get/get.dart';
import 'package:learning_app/app/data/models/info_perso.dart';

import '../../../core/config/api_config.dart';
import '../../../data/models/user.dart';
import '../../../data/services/api_service.dart';

class ProfileController extends GetxController {
  var info = Rxn<InfoPerso>();
  final apiService = Get.find<ApiService>();
  var enrollments = <Map<String, dynamic>>[].obs;
  var loading = false.obs;
  var error = ''.obs;

   var user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    fetchProfileAndEnrollments();
  }

  void fetchProfileAndEnrollments() async {
    loading.value = true;
    try {
      // Récupération des infos utilisateur depuis l'API
      final profile = await apiService.get(ApiConfig.profile, (data) => InfoPerso.fromJson(data['data']));
      info.value = profile;
      // Simuler les cours (remplace ça plus tard par un appel réel)
      await Future.delayed(Duration(seconds: 1));
      enrollments.value = [
        {'id': 1, 'title': 'Flutter Basics'},
        {'id': 2, 'title': 'Advanced Dart'},
      ];

      error.value = '';
    } catch (e) {
      error.value = 'Erreur lors du chargement du profil ou des cours.';
    } finally {
      loading.value = false;
    }
  }
}
