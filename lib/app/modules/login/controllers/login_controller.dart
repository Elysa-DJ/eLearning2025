import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_app/app/data/services/api_service.dart';
import 'package:learning_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  //todo: Implement LoginController

  ApiService _apiService = Get.find<ApiService>();


  final isSubmitting = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose(){
    super.onClose();
    nameController.dispose();
    passwordController.dispose();
  }


  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'S\'il vous plaît entrer votre nom d\'utilisateur';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'S\'il vous plaitez entrer votre mot de passe';
    }
    return null;
  }

  validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }


  Future<void> login() async {

    if (!validateForm()) {
      return;
    }
    try{
      isSubmitting.value = true;
      print('name: ${nameController.text}');
      print('password: ${passwordController.text}');
      await _apiService.login(nameController.text, passwordController.text);
      Get.offAllNamed(Routes.HOME_PAGE);
    }catch(e){
      Get.snackbar('Error', e.toString());
      print('Erreur : $e');
    }
    finally{
      isSubmitting.value = false;
    }


  }





}
