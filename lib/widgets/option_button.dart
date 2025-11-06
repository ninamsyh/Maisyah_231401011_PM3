import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String optionText;
  final String optionLabel;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionButton({
    super.key,
    required this.optionText,
    required this.optionLabel,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF9C27B0) : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF9C27B0) : Colors.grey[300]!,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF9C27B0).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : const Color(0xFF9C27B0),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  optionLabel,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? const Color(0xFF9C27B0) : Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                optionText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
