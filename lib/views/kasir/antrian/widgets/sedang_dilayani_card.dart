import 'package:flutter/material.dart';

class SedangDilayaniCard extends StatefulWidget {
  final String nomor;
  final String nama;
  final String poli;

  final VoidCallback onSelesai;
  final VoidCallback onSkip;

  const SedangDilayaniCard({
    super.key,
    required this.nomor,
    required this.nama,
    required this.poli,
    required this.onSelesai,
    required this.onSkip,
  });

  @override
  State<SedangDilayaniCard> createState() => _SedangDilayaniCardState();
}

class _SedangDilayaniCardState extends State<SedangDilayaniCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // KIRI: NOMOR BESAR & INFO
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Sedang Dilayani',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.nomor,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.nama,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                widget.poli,
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
            ],
          ),

          // KANAN: TOMBOL (SEJAJAR HORIZONTAL)
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildButton(
                    icon: Icons.call,
                    label: 'Panggil\nUlang',
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  _buildButton(
                    icon: Icons.check_circle_outline,
                    label: 'Selesai &\nLanjut',
                    onPressed: widget.onSelesai,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: widget.onSkip,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal[700], // ← Lebih gelap
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
