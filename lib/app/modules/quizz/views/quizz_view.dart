import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/quiz.dart';
import '../controllers/quizz_controller.dart';

class QuizzView extends GetView<QuizzController> {
  final QuizzController controller = Get.put(QuizzController());

  QuizzView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadQuiz('course123', 'chapter456');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz"),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        final quiz = controller.quiz.value;
        if (quiz == null) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Chargement du quiz...', style: TextStyle(fontSize: 16)),
              ],
            ),
          );
        }

        final question = quiz.questions[controller.currentQuestionIndex.value];

        return Column(
          children: [
            // Progress indicator
            _buildProgressIndicator(quiz),
            
            // Main content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildQuestionHeader(quiz),
                    const SizedBox(height: 20),
                    _buildQuestionText(question),
                    const SizedBox(height: 24),
                    Expanded(
                      child: SingleChildScrollView(
                        child: _buildQuestionWidget(question),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Navigation buttons
            _buildNavigationButtons(quiz),
          ],
        );
      }),
    );
  }

  Widget _buildProgressIndicator(Quiz quiz) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Question ${controller.currentQuestionIndex.value + 1} sur ${quiz.questions.length}",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "${((controller.currentQuestionIndex.value + 1) / quiz.questions.length * 100).round()}%",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (controller.currentQuestionIndex.value + 1) / quiz.questions.length,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(Get.context!).primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionHeader(Quiz quiz) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(
              Icons.quiz,
              color: Theme.of(Get.context!).primaryColor,
            ),
            const SizedBox(width: 8),
            Text(
              quiz.title ?? 'Quiz',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionText(Question question) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          question.text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, height: 1.4),
        ),
      ),
    );
  }

  Widget _buildQuestionWidget(Question question) {
    switch (question.type) {
      case QuestionType.multipleChoice:
        return _buildMultipleChoiceWidget(question);
      case QuestionType.multipleSelect:
        return _buildMultipleSelectWidget(question);
      case QuestionType.text:
        return _buildTextWidget(question);
      case QuestionType.calculation:
        return _buildCalculationWidget(question);
      default:
        return _buildUnsupportedWidget();
    }
  }

  Widget _buildMultipleChoiceWidget(Question question) {
    return Column(
      children: question.options!.map((option) {
        return Obx(() {
          final selected = controller.selectedAnswers[question.id] == option.id;
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              title: Text(option.text),
              leading: Radio<String>(
                value: option.id,
                groupValue: controller.selectedAnswers[question.id],
                onChanged: (value) {
                  controller.selectOption(question.id, value);
                },
              ),
              onTap: () => controller.selectOption(question.id, option.id),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: selected ? Theme.of(Get.context!).primaryColor : Colors.grey[300]!,
                  width: selected ? 2 : 1,
                ),
              ),
            ),
          );
        });
      }).toList(),
    );
  }

  Widget _buildMultipleSelectWidget(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text(
            'Sélectionnez toutes les réponses qui s\'appliquent :',
            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey),
          ),
        ),
        ...question.options!.map((option) {
          return Obx(() {
            final selected = (controller.selectedAnswers[question.id] ?? []).contains(option.id);
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: CheckboxListTile(
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: selected ? Theme.of(Get.context!).primaryColor : Colors.grey[300]!,
                    width: selected ? 2 : 1,
                  ),
                ),
              ),
            );
          });
        }).toList(),
      ],
    );
  }

  Widget _buildTextWidget(Question question) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          maxLines: 4,
          onChanged: (value) => controller.selectOption(question.id, value),
          decoration: const InputDecoration(
            labelText: 'Tapez votre réponse ici',
            hintText: 'Entrez votre réponse détaillée...',
            border: OutlineInputBorder(),
            alignLabelWithHint: true,
          ),
        ),
      ),
    );
  }

  Widget _buildCalculationWidget(Question question) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Entrez votre réponse numérique :',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            TextField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) => controller.selectOption(question.id, value),
              decoration: const InputDecoration(
                labelText: 'Réponse',
                hintText: 'Entrez un nombre...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calculate),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnsupportedWidget() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.warning, color: Colors.orange[700]),
            const SizedBox(width: 8),
            const Text(
              'Type de question non supporté',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(Quiz quiz) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous button
          if (controller.currentQuestionIndex.value > 0)
            ElevatedButton.icon(
              onPressed: controller.previousQuestion,
              icon: const Icon(Icons.arrow_back),
              label: const Text("Précédent"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[600],
                foregroundColor: Colors.white,
              ),
            )
          else
            const SizedBox.shrink(),

          // Question indicator dots
          Row(
            children: List.generate(
              quiz.questions.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == controller.currentQuestionIndex.value
                      ? Theme.of(Get.context!).primaryColor
                      : Colors.grey[300],
                ),
              ),
            ),
          ),

          // Next/Submit button
          if (controller.currentQuestionIndex.value < quiz.questions.length - 1)
            ElevatedButton.icon(
              onPressed: controller.nextQuestion,
              icon: const Icon(Icons.arrow_forward),
              label: const Text("Suivant"),
            )
          else
            ElevatedButton.icon(
              onPressed: () => _showSubmitDialog(),
              icon: const Icon(Icons.check),
              label: const Text("Soumettre"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
        ],
      ),
    );
  }

  void _showSubmitDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Soumettre le Quiz'),
        content: const Text('Êtes-vous sûr de vouloir soumettre votre quiz ? Vous ne pourrez plus faire de modifications après la soumission.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.submitQuiz();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('Soumettre'),
          ),
        ],
      ),
    );
  }
}