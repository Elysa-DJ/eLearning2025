import 'package:learning_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../onboarding/views/onboarding_view.dart';
import '../controllers/onboarding2_controller.dart';

class Onboarding2View extends GetView<Onboarding2Controller> {
  const Onboarding2View({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Onboarding(),
    );
  }
}

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image de fond
          Positioned.fill(
            child: Image.asset(
              'assets/ecoliere2.png',
              fit: BoxFit.cover,
            ),
          ),

          // Fond bleu semi-transparent
          Positioned.fill(
            child: Container(
              color: Colors.blue.withOpacity(0.7),
            ),
          ),

          // Bouton retour
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => OnboardingView()), // Retour à l'onboarding
                );
              },
            ),
          ),

          // Contenu principal
          Column(
            children: [
              const SizedBox(height: 50),

              // Logo centré en haut
              Center(
                child: Image.asset(
                  'assets/emonaya.png',
                  width: 80,
                ),
              ),

              const Spacer(),

              // Boutons en bas
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Bouton S'enregistrer
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.REGISTER);
                      },
                      child: const Text(
                        "S’enregistrer",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),

                    // Bouton Se connecter
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.LOGIN);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: const Text(
                        "Se connecter",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
