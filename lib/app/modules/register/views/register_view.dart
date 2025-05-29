import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_app/app/routes/app_pages.dart';
import '../../onboarding2/views/onboarding2_view.dart';
import '../controllers/register_controller.dart';
import 'components/personnal_info_form.dart';
import 'components/account_info_form.dart';
import 'components/cycle_form.dart';
import 'components/classe_form.dart';
import 'components/step_indicator.dart';

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
                    colors: [Color(0xFF03A9F4), Color(0xff281537)]
                  ),
                ),
              ),
            ),
            
            // Back button
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
                        },
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back, color: Colors.blue),
                            SizedBox(width: 5),
                            Text("Back to Login", style: TextStyle(color: Colors.blue)),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                            ),
                            Flexible(
                              child: Obx(() => StepIndicator(
                                    currentStep: controller.currentStep.value,
                                    totalSteps: 5,
                                  )),
                            ),
                          ],
                        ),

                      SizedBox(height: 5),
                      Obx(() => Text(
                        controller.getCurrentStepTitle(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      )),
                      SizedBox(height: 20),
                      Expanded(
                        child: Obx(() {
                          switch (controller.currentStep.value) {
                            case 0:
                              return PersonalInfoForm(controller: controller);
                            case 1:
                              return CycleForm(controller: controller);
                            case 2:
                              return ClassForm(controller: controller);
                            case 3:
                              return AccountInfoForm(controller: controller);
                            default:
                              return PersonalInfoForm(controller: controller);
                          }
                        }),
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