import 'package:flutter/material.dart';
import '../data/questions_data.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final String userName;
  final Map<int, int> userAnswers;

  const ResultScreen({
    super.key,
    required this.userName,
    required this.userAnswers,
  });

  int _calculateScore() {
    int correctAnswers = 0;
    for (var question in questionsData) {
      if (userAnswers[question.id] == question.correctAnswerIndex) {
        correctAnswers++;
      }
    }
    return correctAnswers;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final score = _calculateScore();
    final totalQuestions = questionsData.length;
    final percentage = (score / totalQuestions) * 100;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4CAF50), Color(0xFF009688), Color(0xFF2196F3)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        size: 80,
                        color: Color(0xFFFFD700),
                      ),
                      const SizedBox(height: 20),
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFF4CAF50), Color(0xFF009688)],
                        ).createShader(bounds),
                        child: const Text(
                          'Hasil Kuis',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$userName, kamu berhasil menjawab',
                        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        '$score/$totalQuestions',
                        style: const TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Skor: ${percentage.toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: _getGradeColor(percentage).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          _getGradeMessage(percentage),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _getGradeColor(percentage),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Review Jawaban',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF009688),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ...questionsData.map((question) {
                        final userAnswer = userAnswers[question.id];
                        final isCorrect =
                            userAnswer == question.correctAnswerIndex;
                        final hasAnswered = userAnswer != null;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: hasAnswered
                                ? (isCorrect
                                      ? Colors.green.shade50
                                      : Colors.red.shade50)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: hasAnswered
                                  ? (isCorrect ? Colors.green : Colors.red)
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    hasAnswered
                                        ? (isCorrect
                                              ? Icons.check_circle
                                              : Icons.cancel)
                                        : Icons.help_outline,
                                    color: hasAnswered
                                        ? (isCorrect
                                              ? Colors.green
                                              : Colors.red)
                                        : Colors.grey,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      '#${question.id} ${question.question}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Jawaban Benar: ${question.options[question.correctAnswerIndex]}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                              if (hasAnswered && !isCorrect)
                                Text(
                                  'Jawaban Kamu: ${question.options[userAnswer]}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.red,
                                  ),
                                ),
                              if (!hasAnswered)
                                const Text(
                                  'Tidak dijawab',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9C27B0),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Kembali ke Home',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getGradeColor(double percentage) {
    if (percentage >= 80) return Colors.green;
    if (percentage >= 60) return Colors.blue;
    if (percentage >= 40) return Colors.orange;
    return Colors.red;
  }

  String _getGradeMessage(double percentage) {
    if (percentage >= 80) return '🎉 Luar Biasa!';
    if (percentage >= 60) return '👍 Bagus!';
    if (percentage >= 40) return '💪 Cukup Baik!';
    return '📚 Terus Belajar!';
  }
}
