

import 'package:get/get.dart';
import 'package:learning_app/app/data/models/eleve_model.dart';
import 'package:learning_app/app/data/services/api_service.dart';

import '../../core/config/api_config.dart';

class EleveService extends GetxService {

  Eleve? _eleve;
  final ApiService _apiService = Get.find<ApiService>();
  Eleve? get eleve => _eleve;

  Future<EleveService> init() async {
    _eleve = await getEleve();
    return this;
  }

  Future<Eleve?> getEleve() async {
    try{
      final response = await _apiService.get(ApiConfig.profile, (data) => Eleve.fromJson(data['data']));
      return response;
    }
    catch(e){
     Get.snackbar('Error', e.toString());
      return null;
    }
  }

  Future<EleveService> refresh() async {
    _eleve = await getEleve();
    return this;
  }
  
}