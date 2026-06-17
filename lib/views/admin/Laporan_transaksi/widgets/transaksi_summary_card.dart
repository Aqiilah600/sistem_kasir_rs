import 'package:flutter/material.dart';
import '../../../models/transaksi_model.dart';

class TransactionSummaryCard extends StatelessWidget {
  final String label;
  final Transaksi transaksi;
  final double Function(Transaksi transaksi) valueBuilder;
  final IconData icon;
  final Color iconColor;

  const TransactionSummaryCard({
    super.key,
    required this.label,
    required this.transaksi,
    required this.valueBuilder,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ICON
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(height: 12),

          // LABEL
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),

          // VALUE
          Text(
            formatCurrency(valueBuilder(transaksi)),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: iconColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
