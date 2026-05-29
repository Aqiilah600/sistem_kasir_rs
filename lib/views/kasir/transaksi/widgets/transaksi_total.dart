import 'package:flutter/material.dart';
import 'detail_transaksi_sheet.dart';

class TransaksiTotal extends StatelessWidget {
  const TransaksiTotal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),

        gradient: const LinearGradient(
          colors: [Color(0xFF4CC7B6), Color(0xFF2BAA9A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        children: [
          const Text(
            "Total Pembayaran",
            style: TextStyle(color: Colors.white70),
          ),

          const SizedBox(height: 12),

          const Text(
            "RP 268.000.00",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 12),

          TextButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const DetailTransaksiSheet(),
                    ),
                  );
                },
              );
            },

            icon: const Icon(Icons.visibility, color: Colors.white, size: 18),

            label: const Text(
              "Lihat Detail Transaksi",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
