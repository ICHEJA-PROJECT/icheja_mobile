import 'package:flutter/material.dart';

class IncorrectWordsDisplay extends StatelessWidget {
  final List<String> words;
  const IncorrectWordsDisplay({super.key, required this.words});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFCE4EC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Wrap(
        spacing: 24.0,
        runSpacing: 8.0,
        alignment: WrapAlignment.spaceEvenly,
        children: words
            .map((word) => Text(
                  word,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
