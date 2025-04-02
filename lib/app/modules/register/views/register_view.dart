import 'package:e_learning_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../onboarding2/views/onboarding2_view.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue[300],
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ Color(0xFF03A9F4), Color(0xff281537)]
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
                  MaterialPageRoute(builder: (context) => Onboarding2View()), // Retour à l'onboarding
                );
              },
            ),
          ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.LOGIN);
                        }, // Ajoute l'action pour revenir en arrière
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back, color: Colors.blue),
                            SizedBox(width: 5),
                            Text("Back to Login", style: TextStyle(color: Colors.blue)),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildTextField(Icons.email, "Email"),
                      SizedBox(height: 10),
                      _buildTextField(Icons.lock, "Password", obscureText: true),
                      SizedBox(height: 10),
                      _buildTextField(Icons.lock, "Confirm Password", obscureText: true),
                      SizedBox(height: 10),
                      _buildTextField(Icons.phone, "Phone"),
                      SizedBox(height: 20),
                      SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF03A9F4), Color(0xff281537)],
                              begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                  child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Rend le bouton transparent pour voir le gradient
                  shadowColor: Colors.transparent, // Supprime l'ombre
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(30),
                  ),
                  ),
              child: const Text(
              "Sign Up",
              style: TextStyle(fontSize: 18, color: Colors.white),
              ),
    ),
  ),
),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Widget _buildTextField(IconData icon, String hintText, {bool obscureText = false}) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
