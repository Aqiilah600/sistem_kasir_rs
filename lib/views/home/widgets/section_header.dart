import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text("Detail Transaksi", style: TextStyle(fontWeight: FontWeight.bold)),
        Text("Lihat Selengkapnya", style: TextStyle(color: Colors.teal)),
      ],
    );
  }
}
