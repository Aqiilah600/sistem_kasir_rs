// Lokasi: lib/views/kasir/transaksi/widgets/transaksi_data_pasien.dart

import 'package:flutter/material.dart';
import '../../../models/transaksi_model.dart';
import '../../../../utils/formatter.dart';

class TransaksiDataPasien extends StatelessWidget {
  final Transaksi transaksi;

  const TransaksiDataPasien({super.key, required this.transaksi});

  @override
  Widget build(BuildContext context) {
    final fields = {
      'ID Transaksi': transaksi.idTransaksi,
      'ID RM': transaksi.idRm,
      'Pasien': transaksi.namaPasien,
      'Tarif Dokter': formatRupiah(transaksi.tarifDokter),
      'Tarif Perawat': formatRupiah(transaksi.tarifPerawat),
      'Subtotal Obat': formatRupiah(transaksi.subtotalObat),
      'Status': transaksi.status,
      'Tanggal': transaksi.tanggal,
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TITLE
          Row(
            children: const [
              Icon(Icons.people, color: Colors.teal, size: 20),
              SizedBox(width: 8),
              Text('Data Pasien',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),

          // FIELDS
          ...fields.entries.map((e) => _field(e.key, e.value)),

          const SizedBox(height: 16),

          // TOTAL KESELURUHAN
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              gradient: const LinearGradient(
                colors: [Color(0xFF3AC0A8), Color(0xFF0E8F98)],
              ),
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white),
                children: [
                  const TextSpan(text: 'Total Keseluruhan : '),
                  TextSpan(
                    text: formatRupiah(transaksi.totalKeseluruhan),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 38,
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: value,
                  hintStyle:
                      const TextStyle(fontSize: 12, color: Colors.black87),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  suffixIcon: title == 'Tanggal'
                      ? const Icon(Icons.calendar_today,
                          size: 18, color: Color(0xFF4B5A6A))
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}