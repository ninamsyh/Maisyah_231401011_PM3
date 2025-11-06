import 'package:flutter/material.dart';
import '../models/question_model.dart';
import 'option_button.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final int? selectedAnswer;
  final Function(int) onAnswerSelected;

  const QuestionCard({
    super.key,
    required this.question,
    required this.selectedAnswer,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
            children: [
              Icon(Icons.quiz, color: const Color(0xFF9C27B0), size: 28),
              const SizedBox(width: 10),
              Text(
                'Soal #${question.id}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9C27B0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            question.question,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(
            question.options.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: OptionButton(
                optionText: question.options[index],
                optionLabel: String.fromCharCode(65 + index),
                isSelected: selectedAnswer == index,
                onTap: () => onAnswerSelected(index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
