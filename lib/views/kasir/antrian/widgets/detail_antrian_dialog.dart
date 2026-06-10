import 'package:flutter/material.dart';
import '../../../../models/antrian_model.dart';

class DetailAntriDialog extends StatelessWidget {
  final AntriItem item;

  const DetailAntriDialog({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Detail Antrian',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // CONTENT
            _buildDetailRow(label: 'Waktu Masuk', value: item.waktuMasuk),
            const SizedBox(height: 16),
            _buildDetailRow(
              label: 'Status Antrian',
              value: item.status,
              valueColor: _getStatusColor(),
            ),
            const SizedBox(height: 16),
            _buildDetailRow(label: 'ID Transaksi', value: item.idTransaksi),
            const SizedBox(height: 16),
            _buildDetailRow(
              label: 'No Antrian',
              value: item.nomor.toString().padLeft(2, '0'),
            ),
            const SizedBox(height: 16),
            _buildDetailRow(
              label: 'ID Antrian',
              value: item.idAntrian.toString().padLeft(3, '0'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: valueColor ?? Colors.black,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (item.status) {
      case 'Dipanggil':
        return Colors.teal;
      case 'Menunggu':
        return Colors.orange;
      case 'Selesai':
        return Colors.green;
      case 'Dilewati':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
