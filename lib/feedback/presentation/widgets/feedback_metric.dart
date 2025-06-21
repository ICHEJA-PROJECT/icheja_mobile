import 'package:flutter/material.dart';

class FeedbackMetric extends StatelessWidget {
  final String label;
  final String value;
  const FeedbackMetric({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        Expanded(
          child: Text(value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl),
        ),
      ],
    );
  }
}
