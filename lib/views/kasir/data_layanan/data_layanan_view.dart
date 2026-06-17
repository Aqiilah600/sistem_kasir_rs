// Lokasi: lib/views/kasir/data_layanan/data_layanan_view.dart

import 'package:flutter/material.dart';
import '../../../models/layanan_model.dart';
import '../../../services/layanan_services.dart';
import '../widgets/kasir_bottom_navbar.dart';
import '../widgets/kasir_header.dart';
import 'widgets/layanan_item.dart';

class DataLayananView extends StatefulWidget {
  const DataLayananView({super.key});

  @override
  State<DataLayananView> createState() => _DataLayananViewState();
}

class _DataLayananViewState extends State<DataLayananView> {
  final LayananService _layananService = LayananService();
  late TextEditingController _searchController;

  List<Layanan> allLayanan = [];
  List<Layanan> filteredLayanan = [];

  bool isLoading = true;
  String? errorMessage;

  int currentPage = 1;
  final int itemsPerPage = 4;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _loadLayanan();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // Memuat data layanan dari service.
  // Saat API tersedia, LayananService.getAllLayanan() tinggal
  // diganti isinya tanpa perlu mengubah kode di sini.
  // ============================================================
  Future<void> _loadLayanan() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await _layananService.getAllLayanan();
      setState(() {
        allLayanan = data;
        filteredLayanan = data;
        currentPage = 1;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Gagal memuat data layanan';
        isLoading = false;
      });
    }
  }

  // Filter layanan berdasarkan kata kunci pencarian.
  Future<void> _filterLayanan(String query) async {
    final result = await searchLayanan(query);
    setState(() {
      filteredLayanan = result;
      currentPage = 1; // reset ke halaman 1 setiap kali filter berubah
    });
  }

  // Simple local search implementation. Uses loaded allLayanan to filter
  // by nama (case-insensitive). Returns all items when query is empty.
  Future<List<Layanan>> searchLayanan(String query) async {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return allLayanan;
    return allLayanan.where((l) {
      final nama = (l.nama).toLowerCase();
      return nama.contains(q);
    }).toList();
  }

  int get totalPages => filteredLayanan.isEmpty
      ? 1
      : (filteredLayanan.length / itemsPerPage).ceil();

  List<Layanan> get currentPageItems {
    if (filteredLayanan.isEmpty) return [];

    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;

    // Pengaman agar tidak RangeError jika currentPage > totalPages
    if (startIndex >= filteredLayanan.length) return [];
    if (endIndex > filteredLayanan.length) endIndex = filteredLayanan.length;

    return filteredLayanan.sublist(startIndex, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KasirHeader(),
      bottomNavigationBar: const KasirBottomNavbar(
        currentIndex: 3,
        isLainnyaPage: true,
      ),
      backgroundColor: Colors.grey[100], // Disamakan dengan data obat
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
                  'Data Layanan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Daftar seluruh layanan medis, tarif, dan kategori jasa kesehatan.',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          // SEARCH - gaya disamakan dengan TransaksiSearch
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.fromLTRB(14, 0, 14, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nama Layanan',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterLayanan,
                    onSubmitted: _filterLayanan,
                    decoration: InputDecoration(
                      hintText: 'Input Nama Layanan',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
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
              onPressed: _loadLayanan,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    if (filteredLayanan.isEmpty) {
      return Center(
        child: Text(
          'Layanan tidak ditemukan',
          style: TextStyle(color: Colors.grey[500]),
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // LIST LAYANAN
            ...currentPageItems.map((layanan) => LayananItem(layanan: layanan)),

            // PAGINATION
            const SizedBox(height: 24),
            if (totalPages > 1) _buildPagination(),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // PREV BUTTON
          _buildPageButton(
            icon: Icons.arrow_back,
            onTap: currentPage > 1 ? () => setState(() => currentPage--) : null,
          ),
          const SizedBox(width: 12),

          // PAGE NUMBERS
          ...List.generate(totalPages, (index) {
            int pageNum = index + 1;
            return Row(
              children: [
                _buildPageNumber(
                  pageNum,
                  isActive: currentPage == pageNum,
                  onTap: () => setState(() => currentPage = pageNum),
                ),
                if (index < totalPages - 1) const SizedBox(width: 8),
              ],
            );
          }),
          const SizedBox(width: 12),

          // NEXT BUTTON
          _buildPageButton(
            icon: Icons.arrow_forward,
            onTap: currentPage < totalPages
                ? () => setState(() => currentPage++)
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildPageButton({
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          border: Border.all(
            color: onTap != null ? Colors.grey[300]! : Colors.grey[200]!,
          ),
          borderRadius: BorderRadius.circular(6),
          color: onTap != null ? Colors.white : Colors.grey[100],
        ),
        child: Center(
          child: Icon(
            icon,
            size: 18,
            color: onTap != null ? Colors.grey[700] : Colors.grey[400],
          ),
        ),
      ),
    );
  }

  Widget _buildPageNumber(
    int pageNum, {
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isActive ? Colors.teal : Colors.white,
          border: Border.all(color: isActive ? Colors.teal : Colors.grey[300]!),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            pageNum.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }
}
