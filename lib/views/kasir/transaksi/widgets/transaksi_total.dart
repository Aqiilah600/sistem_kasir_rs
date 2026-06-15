// Lokasi: lib/views/kasir/transaksi/widgets/transaksi_total.dart

import 'package:flutter/material.dart';
import '../../../../models/transaksi_model.dart';
import '../../../../utils/formatter.dart';
import 'detail_transaksi_sheet.dart';

class TransaksiTotal extends StatelessWidget {
  final Transaksi transaksi;
  final String metodePembayaran;
  final VoidCallback onBayar;

  const TransaksiTotal({
    super.key,
    required this.transaksi,
    required this.metodePembayaran,
    required this.onBayar,
  });

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
            'Total Pembayaran',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Text(
            formatRupiah(transaksi.totalKeseluruhan),
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'via $metodePembayaran',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 12),

          // LIHAT DETAIL
          TextButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: DetailTransaksiSheet(transaksi: transaksi),
                  ),
                ),
              );
            },
            icon:
                const Icon(Icons.visibility, color: Colors.white, size: 18),
            label: const Text(
              'Lihat Detail Transaksi',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 8),

          // TOMBOL BAYAR
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onBayar,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF0E8F98),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Proses Pembayaran',
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}