import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/quiz.dart';
import '../controllers/quizz_controller.dart';

class QuizzView extends GetView<QuizzController> {
  // final List<Quizz> quizzes;
 final QuizzController controller = Get.put(QuizzController());

  QuizzView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadQuiz('course123', 'chapter456');

    return Scaffold(
      appBar: AppBar(title: const Text("Quiz")),
      body: Obx(() {
        final quiz = controller.quiz.value;
        if (quiz == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final question = quiz.questions[controller.currentQuestionIndex.value];

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Question ${controller.currentQuestionIndex.value + 1}/${quiz.questions.length}",
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text(question.text,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              _buildQuestionWidget(question),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (controller.currentQuestionIndex.value > 0)
                    ElevatedButton(
                      onPressed: controller.previousQuestion,
                      child: const Text("Previous"),
                    ),
                  if (controller.currentQuestionIndex.value < quiz.questions.length - 1)
                    ElevatedButton(
                      onPressed: controller.nextQuestion,
                      child: const Text("Next"),
                    ),
                  if (controller.currentQuestionIndex.value == quiz.questions.length - 1)
                    ElevatedButton(
                      onPressed: controller.submitQuiz,
                      child: const Text("Submit"),
                    ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _buildQuestionWidget(Question question) {
    switch (question.type) {
      case QuestionType.multipleChoice:
        return Column(
          children: question.options!.map((option) {
            return Obx(() {
              final selected = controller.selectedAnswers[question.id] == option.id;
              return ListTile(
                title: Text(option.text),
                leading: Radio<String>(
                  value: option.id,
                  groupValue: controller.selectedAnswers[question.id],
                  onChanged: (value) {
                    controller.selectOption(question.id, value);
                  },
                ),
              );
            });
          }).toList(),
        );
      case QuestionType.multipleSelect:
        return Column(
          children: question.options!.map((option) {
            return Obx(() {
              final selected = (controller.selectedAnswers[question.id] ?? []).contains(option.id);
              return CheckboxListTile(
                title: Text(option.text),
                value: selected,
                onChanged: (bool? value) {
                  final current = List<String>.from(controller.selectedAnswers[question.id] ?? []);
                  if (value == true) {
                    current.add(option.id);
                  } else {
                    current.remove(option.id);
                  }
                  controller.selectOption(question.id, current);
                },
              );
            });
          }).toList(),
        );
      case QuestionType.text:
        return TextField(
              onChanged: (value) => controller.selectOption(question.id, value),
              decoration: const InputDecoration(labelText: 'Your response'),
            );
      case QuestionType.calculation:
        return TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => controller.selectOption(question.id, value),
              decoration: const InputDecoration(labelText: 'Answer'),
            );
      default:
        return const Text('Unsupported question type');
    }
  }
  }