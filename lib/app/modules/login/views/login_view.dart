import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../onboarding2/views/onboarding2_view.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
        Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
        gradient: LinearGradient(colors:[ Color(0xFF03A9F4), Color(0xff281537)]
        )
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0, left:22 ),
          child: Text('Hello!\n Bienvenu sur notre application',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold
            ),
          ),
        )
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

      Padding(
        padding: const EdgeInsets.only(top:200.0, ),
        child: Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
            color: Colors.white,
            
          ),
            
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right:18),
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email, color: Colors.grey),
                        hintText: "Email",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                     SizedBox(height: 20,),

                   TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                        hintText: "Password",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  SizedBox(height: 20,),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                  ), 

                  SizedBox(height: 30,),
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
                  onPressed: () {
                    Get.toNamed(Routes.HOME_PAGE);
                  },
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Rend le bouton transparent pour voir le gradient
                  shadowColor: Colors.transparent, // Supprime l'ombre
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(30),
                  ),
                  ),
              child: const Text(
              "Login",
              style: TextStyle(fontSize: 18, color: Colors.white),
              ),
    ),
  ),
),

                  SizedBox(height: 30,),
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

                ],
              ),
            ),
            
            ),
      )
        
        ],
      )
    );
  }
}
class SocialIcon extends StatelessWidget {
  final String iconPath;
  const SocialIcon({required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      iconPath,
      height: 40,
      width: 40,
    );
  }
}