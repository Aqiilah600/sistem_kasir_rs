// Lokasi: lib/views/kasir/transaksi/transaksi_view.dart

import 'package:flutter/material.dart';
import '../../../models/transaksi_model.dart';
import '../../../services/transaksi_services.dart';
import '../widgets/kasir_bottom_navbar.dart';
import '../widgets/kasir_header.dart';
import 'widgets/transaksi_search.dart';
import 'widgets/transaksi_data_pasien.dart';
import 'widgets/transaksi_payment.dart';
import 'widgets/transaksi_total.dart';

class TransaksiView extends StatefulWidget {
  const TransaksiView({super.key});

  @override
  State<TransaksiView> createState() => _TransaksiViewState();
}

class _TransaksiViewState extends State<TransaksiView> {
  final TransaksiService _service = TransaksiService();
  final TextEditingController _searchController = TextEditingController();

  Transaksi? _transaksi;
  String _metodePembayaran = 'Cash';
  bool _isLoading = false;
  bool _isBayarLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // Cari transaksi berdasarkan nomor antrian.
  // Saat API tersedia, TransaksiService.getByNoAntrian() tinggal
  // diganti isinya tanpa perlu mengubah kode di sini.
  // ============================================================
  Future<void> _cariTransaksi(String noAntrian) async {
    if (noAntrian.trim().isEmpty) {
      setState(() {
        _transaksi = null;
        _errorMessage = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await _service.getByNoAntrian(noAntrian);
      setState(() {
        _transaksi = result;
        _isLoading = false;
        _errorMessage = result == null ? 'Transaksi tidak ditemukan' : null;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Gagal mengambil data transaksi';
      });
    }
  }

  // ============================================================
  // Proses pembayaran.
  // ============================================================
  Future<void> _prosesBayar() async {
    if (_transaksi == null) return;

    setState(() => _isBayarLoading = true);

    try {
      final berhasil = await _service.bayar(
        _transaksi!.idTransaksi,
        _metodePembayaran,
      );

      if (!mounted) return;

      if (berhasil) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pembayaran berhasil!'),
            backgroundColor: Colors.teal,
          ),
        );
        // Reset form setelah bayar
        setState(() {
          _transaksi = null;
          _searchController.clear();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pembayaran gagal, coba lagi'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Terjadi kesalahan'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isBayarLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const KasirHeader(),
      body: Column(
        children: [
          // HEADER
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Transaksi',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Kelola transaksi pasien dengan mudah dan cepat.',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  // SEARCH — fixed di atas
                  TransaksiSearch(
                    controller: _searchController,
                    onSearch: _cariTransaksi,
                    onTransactionFound: (_) {},
                  ),
                  const SizedBox(height: 14),

                  // KONTEN — scrollable
                  Expanded(child: _buildContent()),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const KasirBottomNavbar(currentIndex: 2),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Text(_errorMessage!, style: TextStyle(color: Colors.grey[500])),
      );
    }

    if (_transaksi == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search, size: 48, color: Colors.grey[300]),
            const SizedBox(height: 12),
            Text(
              'Masukkan nomor antrian untuk\nmencari transaksi',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[400], fontSize: 13),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          TransaksiDataPasien(transaksi: _transaksi!),
          const SizedBox(height: 14),
          TransaksiPayment(
            selectedPayment: _metodePembayaran,
            onChanged: (value) => setState(() => _metodePembayaran = value),
          ),
          const SizedBox(height: 14),
          TransaksiTotal(
            transaksi: _transaksi!,
            metodePembayaran: _metodePembayaran,
            onBayar: _isBayarLoading ? () {} : _prosesBayar,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
