import 'package:flutter/material.dart';
import '../../../models/layanan_model.dart';
import '../widgets/kasir_bottom_navbar.dart';
import '../widgets/kasir_header.dart';
import 'widgets/layanan_item.dart';

class DataLayananView extends StatefulWidget {
  const DataLayananView({super.key});

  @override
  State<DataLayananView> createState() => _DataLayananViewState();
}

class _DataLayananViewState extends State<DataLayananView> {
  late TextEditingController _searchController;
  late List<Layanan> filteredLayanan;
  int currentPage = 1;
  final int itemsPerPage = 4;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    filteredLayanan = dummyLayanan;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterLayanan(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredLayanan = dummyLayanan;
      } else {
        filteredLayanan = dummyLayanan
            .where(
              (layanan) =>
                  layanan.nama.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
      currentPage = 1;
    });
  }

  int get totalPages => (filteredLayanan.length / itemsPerPage).ceil();

  List<Layanan> get currentPageItems {
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    if (endIndex > filteredLayanan.length) {
      endIndex = filteredLayanan.length;
    }
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
      body: Column(
        children: [
          // HEADER & SEARCH - FIXED DI ATAS
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER
                const Text(
                  'Data Layanan',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Daftar seluruh layanan medis, tarif, dan kategori jasa kesehatan.',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
                const SizedBox(height: 24),

                // SEARCH BAR
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterLayanan,
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

          // LIST LAYANAN - SCROLLABLE
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // LIST LAYANAN
                    ...currentPageItems.map(
                      (layanan) => LayananItem(layanan: layanan),
                    ),

                    // PAGINATION
                    const SizedBox(height: 24),
                    if (totalPages > 1) _buildPagination(),
                  ],
                ),
              ),
            ),
          ),
        ],
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
