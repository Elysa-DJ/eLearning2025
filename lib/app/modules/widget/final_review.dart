import 'package:flutter/material.dart';

import '../../data/models/quizz.dart';

class FinalReviewPage extends StatelessWidget {
  final QuizManager quizManager;
  final Function() onReview;
  final Quizz  quizz;

  const FinalReviewPage({
    required this.quizManager,
    required this.onReview,
    required this.quizz,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isPassed = quizManager.score >= quizz.passingScore;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Révision Finale'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: onReview,
            tooltip: 'Retour à l\'accueil',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Text(
              'Quiz: ${quizz.title}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildResultCard(isPassed),
            const SizedBox(height: 30),
            _buildScoreDetails(),
            const Spacer(),
            _buildQuestionSummary(),
            const Spacer(),
            _buildActionButtons(context, isPassed),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(bool isPassed) {
    return Card(
      elevation: 5,
      color: isPassed ? Colors.green.shade50 : Colors.red.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: isPassed ? Colors.green : Colors.red,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(
              isPassed ? Icons.check_circle : Icons.cancel,
              color: isPassed ? Colors.green : Colors.red,
              size: 60,
            ),
            const SizedBox(height: 15),
            Text(
              isPassed ? 'RÉUSSI!' : 'ÉCHOUÉ',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isPassed ? Colors.green.shade800 : Colors.red.shade800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              isPassed 
                  ? 'Félicitations pour votre succès!' 
                  : 'Continuez vos efforts pour améliorer votre score.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: isPassed ? Colors.green.shade700 : Colors.red.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreDetails() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Détails du Score',
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Score final:',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '${quizManager.score}/100',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            _buildStatRow(
              'Réponses correctes:',
              quizManager.correctAnswers.toString(),
              Icons.check_circle_outline,
              Colors.green,
            ),
            const SizedBox(height: 10),
            _buildStatRow(
              'Réponses erronées:',
              quizManager.wrongAnswers.toString(),
              Icons.highlight_off,
              Colors.red,
            ),
            const SizedBox(height: 10),
            _buildStatRow(
              'Score minimum requis:',
              '${quizz.passingScore}%',
              Icons.security,
              Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, IconData icon, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 16)),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionSummary() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.quiz, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'Résumé du Quiz',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 5),
            Text(
              '• Nombre total de questions: ${quizz.questions.length}',
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 5),
            Text(
              '• Temps alloué: ${quizz.timeLimit} minutes',
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isPassed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.refresh),
          label: const Text('Recommencer'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.home),
          label: const Text('Menu Principal'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          onPressed: onReview,
        ),
      ],
    );
  }
}

class QuizManager {
  final List<Quizz> quizzes;
  int _currentQuizIndex = 0;
  String selectedAnswer = '';
  int score = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;
  List<AnswerRecord> answerRecords = [];

  QuizManager(this.quizzes);

  void checkAnswer(String answerId, int questionIndex) {
    if (quizzes.isEmpty || questionIndex >= quizzes[_currentQuizIndex].questions.length) return;
    
    final question = quizzes[_currentQuizIndex].questions[questionIndex];
    
    selectedAnswer = answerId;
    final int answerIdInt = int.tryParse(answerId) ?? -1;
    final bool isCorrect = answerIdInt == question.correctAnswerId;
    
    // Record the answer
    answerRecords.add(AnswerRecord(
      questionId: question.id,
      questionText: question.text,
      selectedAnswerId: answerIdInt,
      correctAnswerId: question.correctAnswerId,
      isCorrect: isCorrect,
    ));
    
    // Update counters
    if (isCorrect) {
      correctAnswers++;
    } else {
      wrongAnswers++;
    }
    
    // Calculate score as percentage
    int totalAnswered = correctAnswers + wrongAnswers;
    if (totalAnswered > 0) {
      score = (correctAnswers * 100 ~/ totalAnswered);
    }
  }
  
  void resetQuiz() {
    selectedAnswer = '';
    score = 0;
    correctAnswers = 0;
    wrongAnswers = 0;
    answerRecords.clear();
  }
  
  List<AnswerRecord> getAnswerRecords() {
    return answerRecords;
  }
}

class AnswerRecord {
  final int questionId;
  final String questionText;
  final int selectedAnswerId;
  final int correctAnswerId;
  final bool isCorrect;
  
  AnswerRecord({
    required this.questionId,
    required this.questionText,
    required this.selectedAnswerId,
    required this.correctAnswerId,
    required this.isCorrect,
  });
}