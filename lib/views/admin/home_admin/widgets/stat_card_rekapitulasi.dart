import 'package:flutter/material.dart';
import '../../../models/dashboard_model.dart';

class StatCardRekapitulasi extends StatelessWidget {
  final DashboardStatistik data;
  final IconData icon;
  final String label; // ← TAMBAH: Label dynamic
  final String value; // ← TAMBAH: Value dynamic

  const StatCardRekapitulasi({
    super.key,
    required this.data,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Container(
      // FIXED HEIGHT untuk semua card sama rata
      height: isSmallScreen ? 125 : 120,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.25 * 255).round()),
            blurRadius: 3,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ICON - CIRCULAR
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFF005461).withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: const Color(0xFF005461), size: 20),
          ),

          // LABEL (DYNAMIC)
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              height: 0,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          // VALUE (DYNAMIC)
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
              height: 0,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          // SUBTITLE
          const Text(
            'hari ini',
            style: TextStyle(
              fontSize: 9,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
