import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/quizz_controller.dart';

class QuizzView extends GetView<QuizzController> {
  // final List<Quizz> quizzes;
 const QuizzView(  {super.key});
  
  Widget buildQuestion(Map question, int index) {
    final type = question['type'];

    switch (type) {
      case 'multiple-choice':
        return Column(
          children: (question['options'] as List<dynamic>).map((option) {
            return Obx(() {
              return ListTile(
                title: Text(option),
                leading: Radio<String>(
                  value: option,
                  groupValue: controller.selectedAnswers[index],
                  onChanged: (value) {
                    controller.selectOption(index, value);
                  },
                ),
              );
            });
          }).toList(),
        );
      case 'calculation':
        return TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Answer"),
              onChanged: (value) => controller.selectOption(index, value),
            );
      case 'text':
        return TextField(
              maxLines: 4,
              decoration: const InputDecoration(labelText: "Your response"),
              onChanged: (value) => controller.selectOption(index, value),
            );
      default:
        return const Text("Unsupported question type.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz")),
      body: Obx(() {
        if (controller.questions.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final index = controller.currentQuestionIndex.value;
        final question = controller.questions[index];

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Question ${index + 1}/${controller.questions.length}",
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text(question['question'] as String,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              buildQuestion(question, index),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (index > 0)
                    ElevatedButton(
                      onPressed: controller.previousQuestion,
                      child: const Text("Previous"),
                    ),
                  if (index < controller.questions.length - 1)
                    ElevatedButton(
                      onPressed: controller.nextQuestion,
                      child: const Text("Next"),
                    ),
                  if (index == controller.questions.length - 1)
                    ElevatedButton(
                      onPressed: controller.submitQuiz,
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              ],
            ),
          );
      }),
    );
  }
  }