import 'package:flutter/material.dart';
import '../../../models/antrian_model.dart';

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
            Table(
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(2),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                _buildDetailRow(label: 'Waktu Masuk', value: item.waktuMasuk),
                _buildDetailRow(
                  label: 'Status Antrian',
                  value: item.status,
                  valueColor: _getStatusColor(),
                ),
                _buildDetailRow(label: 'ID Transaksi', value: item.idTransaksi),
                _buildDetailRow(
                  label: 'No Antrian',
                  value: item.nomor.toString().padLeft(2, '0'),
                ),
                _buildDetailRow(
                  label: 'ID Antrian',
                  value: item.idAntrian.toString().padLeft(3, '0'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildDetailRow({
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            label,
            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: valueColor ?? Colors.black,
              ),
            ),
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
      default:
        return Colors.grey;
    }
  }
}
