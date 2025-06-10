import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/cycle.dart';
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
              ... controller.cycles.value.map<Widget>((cycle) => _buildCycleOption(cycle)),
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
              onPressed: controller.selectedCycle.value!=null 
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

  Widget _buildCycleOption(Cycle value) {
    return Obx(() => GestureDetector(
      onTap: () {
        controller.selectedCycle.value = value;
        controller.selectedClasse.value = null; // Reset class when cycle changes
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
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
              value.libelleC,
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