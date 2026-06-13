// Lokasi: lib/views/kasir/data_obat/data_obat_view.dart

import 'package:flutter/material.dart';
import '../../../models/obat_model.dart';
import '../../../services/obat_services.dart';
import '../widgets/kasir_bottom_navbar.dart';
import '../widgets/kasir_header.dart';
import 'widgets/obat_card.dart';

class DataObatView extends StatefulWidget {
  const DataObatView({super.key});

  @override
  State<DataObatView> createState() => _DataObatViewState();
}

class _DataObatViewState extends State<DataObatView> {
  final ObatService _obatService = ObatService();
  late TextEditingController _searchController;

  List<Obat> filteredObat = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _loadObat();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // Memuat data obat dari service.
  // Saat API tersedia, ObatService.getAllObat() tinggal diganti
  // isinya tanpa perlu mengubah kode di sini.
  // ============================================================
  Future<void> _loadObat() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await _obatService.getAllObat();
      setState(() {
        filteredObat = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Gagal memuat data obat';
        isLoading = false;
      });
    }
  }

  // Filter obat berdasarkan kata kunci pencarian.
  Future<void> _filterObat(String query) async {
    final result = await _obatService.searchObat(query);
    setState(() {
      filteredObat = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const KasirHeader(),
      bottomNavigationBar: const KasirBottomNavbar(
        currentIndex: 3,
        isLainnyaPage: true,
      ),
      body: Column(
        children: [
          // HEADER + SEARCH — FIXED DI ATAS, langsung di dalam view ini
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // HEADER
                const Text(
                  'Data Obat',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'List data obat dan stok yang tersedia di rumah sakit.',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),

                // SEARCH
                const Text(
                  'Nama Obat',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _searchController,
                  onChanged: _filterObat,
                  decoration: InputDecoration(
                    hintText: 'Input Nama Obat',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xFF007F93),
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // KONTEN: LOADING / ERROR / LIST
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(errorMessage!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loadObat,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    if (filteredObat.isEmpty) {
      return Center(
        child: Text(
          'Obat tidak ditemukan',
          style: TextStyle(color: Colors.grey[500]),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredObat.length,
      itemBuilder: (context, index) {
        return ObatCard(obat: filteredObat[index]);
      },
    );
  }
}
