// Lokasi: lib/views/kasir/transaksi/widgets/detail_transaksi_sheet.dart

import 'package:flutter/material.dart';
import '../../../../models/transaksi_model.dart';
import '../../../../utils/formatter.dart';

class DetailTransaksiSheet extends StatelessWidget {
  final Transaksi transaksi;

  const DetailTransaksiSheet({super.key, required this.transaksi});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              children: [
                const Icon(Icons.receipt_long, color: Colors.teal),
                const SizedBox(width: 8),
                const Text(
                  'Detail Transaksi',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(),

            // INFO PASIEN
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFFCCCCCC)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _InfoItem(
                        title: 'No Invoice',
                        value: transaksi.noInvoice,
                      ),
                      _InfoItem(title: 'Pasien', value: transaksi.namaPasien),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _InfoItem(title: 'Tanggal', value: transaksi.tanggal),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // DAFTAR OBAT
            _sectionTitle('Daftar Obat'),
            _tableHeader(),
            ...transaksi.daftarObat.map(
              (item) => _tableRow(
                item.nama,
                item.jumlah.toString(),
                formatRupiah(item.harga),
                formatRupiah(item.subtotal),
              ),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Total Obat : ${formatRupiah(transaksi.totalObat)}',
                style: const TextStyle(
                  color: Color(0xFF007F93),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // DAFTAR LAYANAN
            _sectionTitle('Daftar Layanan'),
            _tableHeader(),
            ...transaksi.daftarLayanan.map(
              (item) => _tableRow(
                item.nama,
                item.jumlah.toString(),
                formatRupiah(item.harga),
                formatRupiah(item.subtotal),
              ),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Total Layanan : ${formatRupiah(transaksi.totalLayanan)}',
                style: const TextStyle(
                  color: Color(0xFF007F93),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // GRAND TOTAL
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF007F93).withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF007F93)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Keseluruhan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formatRupiah(transaksi.totalKeseluruhan),
                    style: const TextStyle(
                      color: Color(0xFF007F93),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF007F93),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _tableHeader() {
    return Container(
      padding: const EdgeInsets.all(8),
      color: const Color(0xFF007F93),
      child: const Row(
        children: [
          Expanded(
            child: Text('Nama', style: TextStyle(color: Colors.white)),
          ),
          Expanded(
            child: Text('Jml', style: TextStyle(color: Colors.white)),
          ),
          Expanded(
            child: Text('Harga', style: TextStyle(color: Colors.white)),
          ),
          Expanded(
            child: Text('Subtotal', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _tableRow(String nama, String jumlah, String harga, String subtotal) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Row(
        children: [
          Expanded(child: Text(nama, style: const TextStyle(fontSize: 12))),
          Expanded(child: Text(jumlah, style: const TextStyle(fontSize: 12))),
          Expanded(child: Text(harga, style: const TextStyle(fontSize: 12))),
          Expanded(child: Text(subtotal, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String title;
  final String value;

  const _InfoItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.black54, fontSize: 12),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF007F93),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
