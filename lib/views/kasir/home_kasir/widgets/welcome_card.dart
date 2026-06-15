import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3BC1A8), Color(0xFF007F93), Color(0xFF005461)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // TEKS — diberi margin kiri agar tidak tertimpa gambar dokter
          Padding(
            padding: const EdgeInsets.only(left: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Selamat datang di Sistem Kasir',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Di sini Anda dapat memanggil antrian pasien dan melayani proses pembayaran hingga mencetak bukti bayar.',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ],
            ),
          ),

          // GAMBAR DOKTER
          Positioned(
            bottom: -12,
            top: -20,
            left: -16,
            child: Image.asset('assets/dokter_card.png', height: 120),
          ),
        ],
      ),
    );
  }
}
