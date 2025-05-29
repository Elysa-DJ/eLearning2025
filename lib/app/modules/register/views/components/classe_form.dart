import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            List<Map<String, String>> classes = _getClassesForCycle(controller.selectedCycle.value);
            
            if (classes.isEmpty) {
              return Center(
                child: Text(
                  "Veuillez d'abord sélectionner un cycle",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              );
            }
            
            return ListView.separated(
              itemCount: classes.length,
              separatorBuilder: (context, index) => SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _buildClassOption(classes[index]['title']!, classes[index]['value']!);
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
              onPressed: controller.selectedClass.value.isNotEmpty 
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

  Widget _buildClassOption(String title, String value) {
    return Obx(() => GestureDetector(
      onTap: () {
        controller.selectedClass.value = value;
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: controller.selectedClass.value == value 
                ? Colors.blue 
                : Colors.grey[300]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          color: controller.selectedClass.value == value 
              ? Colors.blue.withOpacity(0.1) 
              : Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              controller.selectedClass.value == value 
                  ? Icons.radio_button_checked 
                  : Icons.radio_button_unchecked,
              color: controller.selectedClass.value == value 
                  ? Colors.blue 
                  : Colors.grey[400],
            ),
            SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: controller.selectedClass.value == value 
                    ? FontWeight.w600 
                    : FontWeight.normal,
                color: controller.selectedClass.value == value 
                    ? Colors.blue[800] 
                    : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  List<Map<String, String>> _getClassesForCycle(String cycle) {
    switch (cycle) {
      case 'primary':
        return [
          {'title': 'CP', 'value': 'cp'},
          {'title': 'CE1', 'value': 'ce1'},
          {'title': 'CE2', 'value': 'ce2'},
          {'title': 'CM1', 'value': 'cm1'},
          {'title': 'CM2', 'value': 'cm2'},
        ];
      case 'college':
        return [
          {'title': '6ème', 'value': '6eme'},
          {'title': '5ème', 'value': '5eme'},
          {'title': '4ème', 'value': '4eme'},
          {'title': '3ème', 'value': '3eme'},
        ];
      case 'highschool':
        return [
          {'title': 'Seconde', 'value': 'seconde'},
          {'title': 'Première', 'value': 'premiere'},
          {'title': 'Terminale', 'value': 'terminale'},
        ];
      case 'university':
        return [
          {'title': 'Licence 1', 'value': 'l1'},
          {'title': 'Licence 2', 'value': 'l2'},
          {'title': 'Licence 3', 'value': 'l3'},
          {'title': 'Master 1', 'value': 'm1'},
          {'title': 'Master 2', 'value': 'm2'},
          {'title': 'Doctorat', 'value': 'phd'},
        ];
      case 'professional':
        return [
          {'title': 'CAP', 'value': 'cap'},
          {'title': 'BEP', 'value': 'bep'},
          {'title': 'Bac Pro', 'value': 'bac_pro'},
          {'title': 'BTS', 'value': 'bts'},
          {'title': 'DUT', 'value': 'dut'},
        ];
      default:
        return [];
    }
  }
}