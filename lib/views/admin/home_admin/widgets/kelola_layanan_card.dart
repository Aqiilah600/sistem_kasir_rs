import 'package:flutter/material.dart';

class KelolaLayananCard extends StatelessWidget {
  const KelolaLayananCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F8F5),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.08 * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // ICON CONTAINER
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFF3AC0A8).withAlpha((0.2 * 255).round()),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.checklist_rtl,
              color: Color(0xFF3AC0A8),
              size: 36,
            ),
          ),
          const SizedBox(width: 16),

          // TEXT SECTION
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Kelola Layanan dengan Mudah',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Semua informasi penting dalam genggaman anda.',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // ADD ICON BUTTON
          Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            child: Image.asset('assets/papancatatan.png', fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }
}
