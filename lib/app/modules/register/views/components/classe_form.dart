import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_app/app/data/models/classe.dart';
import '../../controllers/register_controller.dart';

class ClassForm extends StatelessWidget {
  final RegisterController controller;

  const ClassForm({Key? key, required this.controller}) : super(key: key);

  @override
 Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sélectionnez votre classe",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: Obx(() {

            if (controller.selectedCycle.value == null || controller.selectedCycle.value!.classes.isEmpty) {
              return Center(
                child: Text(
                  "Veuillez d'abord sélectionner un cycle",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              );
            }
            
            return ListView.separated(
              itemCount: controller.selectedCycle.value!.classes.length,
              separatorBuilder: (context, index) => SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _buildClassOption(controller.selectedCycle.value!.classes[index]);
              },
            );
          }),
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
              onPressed: controller.selectedClasse.value != null 
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

  Widget _buildClassOption(Classe classe) {
    return Obx(() => GestureDetector(
      onTap: () {
        controller.selectedClasse.value = classe;
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: controller.selectedClasse.value == classe 
                ? Colors.blue 
                : Colors.grey[300]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          color: controller.selectedClasse.value == classe 
              ? Colors.blue.withOpacity(0.1) 
              : Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              controller.selectedClasse.value == classe 
                  ? Icons.radio_button_checked 
                  : Icons.radio_button_unchecked,
              color: controller.selectedClasse.value == classe 
                  ? Colors.blue 
                  : Colors.grey[400],
            ),
            SizedBox(width: 12),
            Text(
              classe.libelleCl,
              style: TextStyle(
                fontSize: 16,
                fontWeight: controller.selectedClasse.value == classe 
                    ? FontWeight.w600 
                    : FontWeight.normal,
                color: controller.selectedClasse.value == classe 
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