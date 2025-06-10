import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';


import '../../../core/config/api_config.dart';
import '../../../data/models/classe.dart';
import '../../../data/models/cycle.dart';
import '../../../data/services/api_service.dart';
import '../../../routes/app_pages.dart';
import '../views/components/confirmation_form.dart';

class RegisterController extends GetxController {
  
 final isSubmitting = false.obs;
 final ApiService _apiService = Get.find<ApiService>();

  final Rx<List> cycles = Rx<List>([]);
  final Rx<Cycle?> selectedCycle = Rx<Cycle?>(null);
  final Rx<Classe?> selectedClasse = Rx<Classe?>(null);

  final isRegistered = false.obs;
  // Loading state
  final isLoading = false.obs;
  
  // Current step tracker (0 à 3 maintenant - confirmation n'est plus une étape)
  final currentStep = 0.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
  final birthPlaceController = TextEditingController();
  final nationalityController = TextEditingController();
  final academicYearController = TextEditingController();
  final genderController = TextEditingController();
    // Classe (étape 2)


  final selectedNationality = 'Congo'.obs;
  final selectedGender = 'Féminin'.obs;




  
  // Account information form fields (étape 3)
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  
  // Date of birth
  final selectedDate = Rx<DateTime?>(null);

  



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

  @override
  void onInit()async {
    super.onInit();
    await fetchCycles();
  }
  
  void nextStep() {
    switch (currentStep.value) {
      case 0:
        if (personalInfoFormKey.currentState!.validate()) {
          currentStep.value++;
        }
        break;
      case 1:
        if (selectedCycle.value!=null) {
          currentStep.value++;
        }
        break;
      case 2:
        if (selectedClasse.value != null) {
          currentStep.value++;
        }
        break;
      case 3:
        if (accountInfoFormKey.currentState!.validate()) {
          // Ici on pourrait aller à une page de confirmation séparée
          // mais pour l'instant on garde la logique d'inscription
          register();
        }
        break;
    }
  }
  
  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
      // Reset la classe si on revient au cycle
      if (currentStep.value == 1) {
        selectedClasse.value = null;
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
        return selectedCycle.value != null;
      case 2:
        return selectedClasse.value != null;
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
      dateOfBirthController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  // Validation methods
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

  String? validateBirthPlace(String? value) {
    if (value == null || value.isEmpty) {
      return 'Birth place is required';
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



String? validateGender(String? value) {
  if (value == null || value.isEmpty) {
    return 'Le sexe est requis';
  }
  return null;
}

String? validateNationality(String? value) {
  if (value == null || value.isEmpty) {
    return 'La nationalité est requise';
  }
  return null;
}

String? validateAcademicYear(String? value) {
  if (value == null || value.isEmpty) {
    return 'L\'année scolaire est requise';
  }
  return null;
}
  
  String? validateCycle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cycle is required';
    }
    return null;
  }
  
  String? validateClass(String? value) {
    if (value == null || value.isEmpty) {
      return 'Class is required';
    }
    return null;
  }
  
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }
  
  Future<void> fetchCycles() async{
    try {
      final response = await _apiService.get<List<Cycle>>(
        ApiConfig.fetchCycles,
        (data) =>Cycle.fromArrayJson(data['data']),
      );
      cycles.value = response;
    } catch (e) {
      print('Error fetching cycles: $e');
    }
  }

  // Méthode corrigée pour l'inscription
  Future<void> register() async {
    try {

      isRegistered.value = true;

      print(        
        {
          'nom': nameController.text,
          'prenom': surnameController.text,
          'date_N': selectedDate.value?.toIso8601String(),
          'lieu_N': birthPlaceController.text,
          'ville_residence': cityController.text,
          'email': emailController.text,
          'name': usernameController.text,
          'password': passwordController.text,
          'telephone': phoneController.text,
          'sexe': genderController.text,
          'nationalite': nationalityController.text,
          'classe_id': selectedClasse.value!.id
        });

      final response = await _apiService.post<Map<String, dynamic>>(
        ApiConfig.register,
        {
          'nom': nameController.text,
          'prenom': surnameController.text,
          'date_N': dateOfBirthController.text,
          'lieu_N': birthPlaceController.text,
          'ville_residence': cityController.text,
          'email': emailController.text,
          'name': usernameController.text,
          'password': passwordController.text,
          'telephone': phoneController.text,
          'sexe': genderController.text,
          'nationalite': nationalityController.text,
          'classe_id': selectedClasse.value!.id
        },

        (data) => data as Map<String, dynamic>,
      );
      
      // Afficher un message de succès
      Get.snackbar(
        'Succès',
        response['message'],
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      
      // Rediriger vers la page d'accueil
      Get.offAllNamed(Routes.LOGIN);
      isRegistered.value = false;
    } catch (e) {
      // Gestion des erreurs
      String errorMessage = 'Une erreur est survenue lors de l\'inscription';
      
      if (e is ApiException) {
        errorMessage = e.message;
      } else {
        errorMessage = e.toString();
      }
      
      Get.snackbar(
        'Erreur',
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
      );
      
      print('Erreur inscription: $e');
    } finally {
      // Désactiver le loading
      isRegistered.value = false;
    }
  }


  // Future<void> fetchCycles() async {
  //   try {
  //     cycles.value = await _apiService.get();
  //   } catch (e) {
  //     print('Error fetching cycles: $e');
  //   }
  // }

  // Future<void> fetchAcademicYears() async {
  //   try {
  //     academicYears.value = await _apiService.fetchAcademicYears();
  //   } catch (e) {
  //     print('Error fetching academic years: $e');
  //   }
  // }
}