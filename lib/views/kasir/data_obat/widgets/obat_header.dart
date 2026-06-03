import 'package:flutter/material.dart';

class ObatHeader extends StatelessWidget {
  const ObatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Data Obat",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          "List data Obat",
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}