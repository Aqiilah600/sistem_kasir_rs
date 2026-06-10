import 'package:flutter/material.dart';
import '../../../../models/antrian_model.dart';

class AntriListItem extends StatelessWidget {
  final AntriItem item;
  final VoidCallback onDetailTap;

  const AntriListItem({
    super.key,
    required this.item,
    required this.onDetailTap,
  });

  Color _getStatusColor() {
    switch (item.status) {
      case 'Dipanggil':
        return Colors.teal;
      case 'Menunggu':
        return const Color(0xFFF59E0B);
      case 'Selesai':
        return const Color(0xFF8B5CF6);
      case 'Dilewati':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // NOMOR ANTRIAN
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF0D7B74),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                item.nomor.toString().padLeft(2, '0'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // INFO: NAMA & POLI
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.nama,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.poli,
                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                ),
              ],
            ),
          ),

          // STATUS BADGE - pill shape
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: _getStatusColor().withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _getStatusColor().withOpacity(0.3)),
            ),
            child: Text(
              item.status,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _getStatusColor(),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // ICON DETAIL
          GestureDetector(
            onTap: onDetailTap,
            child: Icon(
              Icons.visibility_outlined,
              size: 18,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
