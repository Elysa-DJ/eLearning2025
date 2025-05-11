import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  // Current step tracker
  final currentStep = 0.obs;
  
  // Form keys for validation
  final personalInfoFormKey = GlobalKey<FormState>();
  final accountInfoFormKey = GlobalKey<FormState>();
  
  // Personal information form fields
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final cityController = TextEditingController();
  final emailController = TextEditingController();
  
  // Account information form fields
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  
  // Date of birth
  final selectedDate = Rx<DateTime?>(null);
  
  void nextStep() {
    if (currentStep.value == 0) {
      if (personalInfoFormKey.currentState!.validate()) {
        currentStep.value++;
      }
    }
  }
  
  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
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