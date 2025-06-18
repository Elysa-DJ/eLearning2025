import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../onboarding2/views/onboarding2_view.dart';
import '../../widget/gradient_button.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // important !
      body: Stack(
        children: [
          // Fond dégradé bleu
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF03A9F4), Color(0xff281537)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Bienvenue sur Emonaya Learn',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Bouton retour
          Positioned(
            top: 10,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Onboarding2View()),
                );
              },
            ),
          ),

          // Container Formulaire avec scroll
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: SingleChildScrollView(
                // rend scrollable quand clavier apparaît
                padding: const EdgeInsets.only(bottom: 30),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: controller.nameController,
                        validator: controller.validateName,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person, color: Colors.grey),
                          hintText: "Nom d'utilisateur",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        controller: controller.passwordController,
                        validator: controller.validatePassword,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                          hintText: "Mot de passe",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Mot de passe oublié ?",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Obx(() => GradientAuthButton(
                            isSubmitting: controller.isSubmitting.value,
                            onPressed: () {
                              controller.login();
                            },
                            text: "Se connecter",
                          )),
                      const SizedBox(height: 30),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialIcon(iconPath: "assets/google.png"),
                          SizedBox(width: 20),
                          SocialIcon(iconPath: "assets/facebook.png"),
                          SizedBox(width: 20),
                          SocialIcon(iconPath: "assets/apple.png"),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final String iconPath;
  const SocialIcon({required this.iconPath, super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      iconPath,
      height: 40,
      width: 40,
    );
  }
}
