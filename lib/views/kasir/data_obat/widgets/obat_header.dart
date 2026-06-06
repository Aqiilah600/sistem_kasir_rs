import 'package:flutter/material.dart';

class ObatHeader extends StatelessWidget {
  const ObatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Data Obat",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          Text("List data Obat", style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }
}
