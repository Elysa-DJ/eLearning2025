import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/components/confirmation_form.dart';

class RegisterController extends GetxController {
  // Current step tracker (0 à 3 maintenant - confirmation n'est plus une étape)
  final currentStep = 0.obs;
  
  // Form keys for validation
  final personalInfoFormKey = GlobalKey<FormState>();
  final cycleFormKey = GlobalKey<FormState>();
  final classFormKey = GlobalKey<FormState>();
  final accountInfoFormKey = GlobalKey<FormState>();
  final confirmationFormKey = GlobalKey<FormState>();
  
  // Personal information form fields (étape 0)
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final cityController = TextEditingController();
  final emailController = TextEditingController();
  
  // Cycle d'études (étape 1)
  final selectedCycle = ''.obs;
  
  // Classe (étape 2)
  final selectedClass = ''.obs;
  
  // Account information form fields (étape 3)
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  
  // Date of birth
  final selectedDate = Rx<DateTime?>(null);
  
  void nextStep() {
    switch (currentStep.value) {
      case 0:
        if (personalInfoFormKey.currentState!.validate()) {
          currentStep.value++;
        }
        break;
      case 1:
        if (selectedCycle.value.isNotEmpty) {
          currentStep.value++;
        }
        break;
      case 2:
        if (selectedClass.value.isNotEmpty) {
          currentStep.value++;
        }
        break;
      case 3:
        if (accountInfoFormKey.currentState!.validate()) {
          // Ici on pourrait aller à une page de confirmation séparée
          // mais pour l'instant on garde la logique d'inscription
          registerUser();
        }
        break;
    }
  }
  
  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
      // Reset la classe si on revient au cycle
      if (currentStep.value == 1) {
        selectedClass.value = '';
      }
    }
  }
  
  void goToConfirmationStep() {
    if (accountInfoFormKey.currentState!.validate()) {
      // Naviguer vers une page de confirmation séparée
      Get.to(() => ConfirmationPage(controller: this,), binding: BindingsBuilder(() {
        Get.put<RegisterController>(this);
      }));
      // Ou utiliser Get.toNamed si vous avez des routes définies
      // Get.toNamed('/confirmation');
    }
  }
  
  
  
  String getCurrentStepTitle() {
    switch (currentStep.value) {
      case 0:
        return "Personal Information";
      case 1:
        return "Cycle d'études";
      case 2:
        return "Classe";
      case 3:
        return "Account Information";
      default:
        return "";
    }
  }

  bool canProceedFromCurrentStep() {
    switch (currentStep.value) {
      case 0:
        return personalInfoFormKey.currentState?.validate() ?? false;
      case 1:
        return selectedCycle.value.isNotEmpty;
      case 2:
        return selectedClass.value.isNotEmpty;
      case 3:
        return accountInfoFormKey.currentState?.validate() ?? false;
      default:
        return false;
    }
  }
  
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      selectedDate.value = picked;
      dateOfBirthController.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }
  
  void registerUser() {
    if (accountInfoFormKey.currentState!.validate()) {
      // TODO: Implement user registration logic
      print('User registration data:');
      print('Name: ${nameController.text}');
      print('Surname: ${surnameController.text}');
      print('Date of Birth: ${dateOfBirthController.text}');
      print('City: ${cityController.text}');
      print('Email: ${emailController.text}');
      print('Cycle: ${selectedCycle.value}');
      print('Classe: ${selectedClass.value}');
      print('Username: ${usernameController.text}');
      print('Password: ${passwordController.text}');
      print('Phone: ${phoneController.text}');
      
      // Proceed with registration
      // Get.offAllNamed(Routes.HOME);
    }
  }
  
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }
  
  String? validateSurname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Surname is required';
    }
    return null;
  }
  
  String? validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date of birth is required';
    }
    return null;
  }
  
  String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'City is required';
    }
    return null;
  }
  
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
  
  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    return null;
  }
  
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
  
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
  
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Phone is optional
    }
    if (!GetUtils.isPhoneNumber(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
  
  @override
  void onClose() {
    nameController.dispose();
    surnameController.dispose();
    dateOfBirthController.dispose();
    cityController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}