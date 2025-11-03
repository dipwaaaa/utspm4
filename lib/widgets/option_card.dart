import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String option;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionCard({
    super.key,
    required this.option,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final labels = ['A', 'B', 'C', 'D'];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.85,
        margin: EdgeInsets.symmetric(vertical: size.height * 0.008),
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.02,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFA47BB8) : Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: size.width * 0.1,
              height: size.width * 0.1,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : const Color(0xFFE8D5F2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  labels[index],
                  style: TextStyle(
                    color: isSelected ? const Color(0xFFA47BB8) : const Color(0xFF8B5BA8),
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.045,
                  ),
                ),
              ),
            ),
            SizedBox(width: size.width * 0.04),
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  fontSize: size.width * 0.04,
                  color: isSelected ? Colors.white : const Color(0xFF6B4C7A),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}