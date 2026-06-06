import 'package:flutter/material.dart';

class DilewatiItem extends StatelessWidget {
  final String nomor;
  final String nama;
  final String poli;
  final VoidCallback onPanggilUlang;

  const DilewatiItem({
    super.key,
    required this.nomor,
    required this.nama,
    required this.poli,
    required this.onPanggilUlang,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              nomor,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  poli,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),

          Column(
            children: [
              ElevatedButton(
                onPressed: onPanggilUlang,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text(
                  "Panggil",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 6),
              ElevatedButton(
                onPressed: onPanggilUlang,
                child: const Text("Panggil Ulang"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
