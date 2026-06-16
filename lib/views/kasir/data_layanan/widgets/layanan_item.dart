import 'package:flutter/material.dart';
import '../../../models/layanan_model.dart';

class LayananItem extends StatefulWidget {
  final Layanan layanan;

  const LayananItem({super.key, required this.layanan});

  @override
  State<LayananItem> createState() => _LayananItemState();
}

class _LayananItemState extends State<LayananItem>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _rotateAnimation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
    if (isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // HEADER - SELALU TERLIHAT
          GestureDetector(
            onTap: _toggleExpand,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // ICON
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      widget.layanan.icon, // ← IconData ✓
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // INFO: NAMA & ID
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.layanan.nama,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'ID Lyn : ${widget.layanan.idLayanan}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // STATUS: AKTIF
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      widget.layanan.aktif ? 'Aktif' : 'Nonaktif',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.green[700],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // CHEVRON ICON (ANIMATED)
                  RotationTransition(
                    turns: _rotateAnimation,
                    child: Icon(
                      Icons.expand_more,
                      color: Colors.teal,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // DIVIDER
          if (isExpanded) Divider(height: 1, color: Colors.grey[300]),

          // EXPANDED CONTENT - INFORMASI TARIF
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi Layanan',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildTarifRow(
                    label: 'Tarif Dokter',
                    tarif: widget.layanan.tarifDokter,
                  ),
                  const SizedBox(height: 12),
                  _buildTarifRow(
                    label: 'Tarif Perawat',
                    tarif: widget.layanan.tarifPerawat,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    label: 'Kategori',
                    value: widget.layanan.kategori,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTarifRow({required String label, required int tarif}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.person, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        Text(
          _formatCurrency(tarif),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildInfoRow({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        Text(
          value,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  String _formatCurrency(int value) {
    return 'Rp ${value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }
}
