// Lokasi: lib/views/kasir/transaksi/widgets/transaksi_search.dart

import 'package:flutter/material.dart';
import '../../../../models/transaksi_model.dart';

class TransaksiSearch extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final Function(Transaksi?) onTransactionFound;

  const TransaksiSearch({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onTransactionFound,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'No Antrian',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.teal),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              onChanged: onSearch,
              onSubmitted: onSearch,
              decoration: InputDecoration(
                hintText: 'Input No Antrian',
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
    );
  }
}
