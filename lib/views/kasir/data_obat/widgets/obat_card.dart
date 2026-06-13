// Lokasi: lib/views/kasir/data_obat/widgets/obat_card.dart

import 'package:flutter/material.dart';
import '../../../../models/obat_model.dart';
import '../../../../utils/formatter.dart';

class ObatCard extends StatelessWidget {
  final Obat obat;

  const ObatCard({super.key, required this.obat});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F4F3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.medication_outlined,
              color: Color(0xFF008B8B),
              size: 40,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  obat.nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(obat.jenis, style: TextStyle(color: Colors.grey[600])),
                const SizedBox(height: 8),
                Text(
                  'Stok ${obat.stok} · ${formatRupiah(obat.harga)}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF39B7A6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Exp: ${obat.exp}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
