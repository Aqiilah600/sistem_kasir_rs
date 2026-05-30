import 'package:flutter/material.dart';

class AntrianItem extends StatelessWidget {
  final String nomor;
  final String nama;
  final String poli;
  final String status;
  final bool isSkipped;

  const AntrianItem({
    super.key,
    required this.nomor,
    required this.nama,
    required this.poli,
    this.status = '',
    this.isSkipped = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isSkipped ? Colors.red : Colors.teal,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              nomor,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  poli,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          if (status.isNotEmpty)
            Text(
              status,
              style: TextStyle(
                fontSize: 11,
                color: status == 'Dipanggil' ? Colors.teal : Colors.orange,
              ),
            ),
          const SizedBox(width: 8),
          const Icon(Icons.visibility, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
