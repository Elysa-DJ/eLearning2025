import 'package:flutter/material.dart';
//import 'package:e_learning_app/app/modules/widget/logo.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
        return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );

  }
}

class SplashScreen extends StatelessWidget {
  final controller = Get.find<SplashController>();
  @override
  Widget build(BuildContext context) {
   controller.checkLoginStatus();
    return Scaffold(
      body: Stack(
        children: [
          // Fond bleu avec vague
          Container(
            color: Colors.blue[500],
            child: Column(
              children: [
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    height: 200,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Image.asset(
                    'assets/emonaya.png', // Remplace avec ton image
                    width: 150,
                    height: 200,
                  ),
                  const SizedBox(height: 20), // Espacement entre le logo et le loader
                  const CircularProgressIndicator(),
                    ],
                   ),
                  ),    
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height - 30);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height - 60, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}