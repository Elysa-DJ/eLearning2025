import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/register_controller.dart';

class CycleForm extends StatelessWidget {
  final RegisterController controller;

  const CycleForm({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sélectionnez votre cycle d'études",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: ListView(
            children: [
              _buildCycleOption("Primaire", "primary"),
              SizedBox(height: 15),
              _buildCycleOption("Collège", "college"),
              SizedBox(height: 15),
              _buildCycleOption("Lycée", "highschool"),
              SizedBox(height: 15),
              _buildCycleOption("Université", "university"),
              SizedBox(height: 15),
              _buildCycleOption("Formation professionnelle", "professional"),
            ],
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                controller.previousStep();
              },
              child: Text("Précédent", style: TextStyle(color: Colors.grey[600])),
            ),
            Obx(() => ElevatedButton(
              onPressed: controller.selectedCycle.value.isNotEmpty 
                  ? () => controller.nextStep()
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                disabledBackgroundColor: Colors.grey[300],
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text("Suivant", style: TextStyle(color: Colors.white)),
            )),
          ],
        ),
      ],
    );
  }

  Widget _buildCycleOption(String title, String value) {
    return Obx(() => GestureDetector(
      onTap: () {
        controller.selectedCycle.value = value;
        controller.selectedClass.value = ""; // Reset class when cycle changes
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: controller.selectedCycle.value == value 
                ? Colors.blue 
                : Colors.grey[300]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          color: controller.selectedCycle.value == value 
              ? Colors.blue.withOpacity(0.1) 
              : Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              controller.selectedCycle.value == value 
                  ? Icons.radio_button_checked 
                  : Icons.radio_button_unchecked,
              color: controller.selectedCycle.value == value 
                  ? Colors.blue 
                  : Colors.grey[400],
            ),
            SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: controller.selectedCycle.value == value 
                    ? FontWeight.w600 
                    : FontWeight.normal,
                color: controller.selectedCycle.value == value 
                    ? Colors.blue[800] 
                    : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}