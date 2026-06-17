import 'package:flutter/material.dart';
import '../widgets/kasir_bottom_navbar.dart';
import '../widgets/kasir_header.dart';
import 'widgets/detail_transaksi_dialog.dart'; // Import pop-up dialog
import '../../../models/r_transaksi_model.dart';

class TransaksiView extends StatefulWidget {
  const TransaksiView({super.key});

  @override
  State<TransaksiView> createState() => _TransaksiViewState();
}

class _TransaksiViewState extends State<TransaksiView> {
  final TextEditingController _searchController = TextEditingController();

  final TransaksiService _service = TransaksiService();

  List<RTransaksi> _allTransaksi = [];
  List<RTransaksi> _filteredTransaksi = [];

  @override
  void initState() {
    super.initState();
    // load dummy data from model/service
    _service.getAllTransaksi().then((list) {
      setState(() {
        _allTransaksi = list;
        _filteredTransaksi = _allTransaksi;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterTransaksi(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredTransaksi = _allTransaksi;
      } else {
        _filteredTransaksi = _allTransaksi
            .where(
              (item) =>
                  item.pasien.toLowerCase().contains(query.toLowerCase()) ||
                  item.invoice.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  // Fungsi memicu modal detail pop-up (Sesuai Gambar 2)
  void _showDetailDialog(Map<String, dynamic> transaksi) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => DetailTransaksiDialog(transaksi: transaksi),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const KasirHeader(),
      bottomNavigationBar: const KasirBottomNavbar(
        currentIndex: 3, // Mengaktifkan tab 'Lainnya'
        isLainnyaPage: true,
      ),
      body: Column(
        children: [
          // Sub-Header Halaman
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Riwayat Transaksi',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Lihat semua histori semua pembayara pasien', // Mengikuti typo asli mockup gambar Anda
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Column(
                children: [
                  // SEARCH BAR — Pola identik dengan DataObatView
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nama Pasien',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF005461)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: _filterTransaksi,
                            decoration: InputDecoration(
                              hintText: 'Input Nama Pasien',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey[400],
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // LIST DATA RIWAYAT
                  Expanded(
                    child: _filteredTransaksi.isEmpty
                        ? Center(
                            child: Text(
                              'Riwayat transaksi tidak ditemukan',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _filteredTransaksi.length,
                            itemBuilder: (context, index) {
                              final item = _filteredTransaksi[index];
                              final isCash = item.metode == 'Cash';

                              return Card(
                                margin: const EdgeInsets.only(bottom: 10),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      // Kotak Ikon Buku Hijau Kiri
                                      Container(
                                        width: 50,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE6F4F4),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.book,
                                          color: Color(0xFF007A87),
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      // Informasi Transaksi Tengah
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.tanggal,
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.grey[400],
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              item.invoice,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                              ),
                                            ),
                                            Text(
                                              item.pasien,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            Text(
                                              item.poli,
                                              style: const TextStyle(
                                                fontSize: 11,
                                                color: Color(0xFF007A87),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Status Badge & Tombol Aksi Kanan
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 3,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isCash
                                                  ? const Color(0xFFE2F7E2)
                                                  : const Color(0xFFE3F2FD),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              item.metode,
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: isCash
                                                    ? Colors.green[700]
                                                    : Colors.blue[700],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          // Tombol Mata (View Detail)
                                          GestureDetector(
                                            onTap: () =>
                                                _showDetailDialog(item.toMap()),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 14,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey[300]!,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: const Icon(
                                                Icons.visibility_outlined,
                                                size: 16,
                                                color: Color(0xFF005461),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
