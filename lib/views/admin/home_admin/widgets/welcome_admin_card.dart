import 'package:flutter/material.dart';

class WelcomeAdminCard extends StatelessWidget {
  const WelcomeAdminCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Container(
      width: double.infinity,
      // KURANGI HEIGHT: 140→120, 160→135
      height: isSmallScreen ? 120 : 135,
      padding: EdgeInsets.all(isSmallScreen ? 14 : 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3BC1A8), Color(0xFF007F93), Color(0xFF005461)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            children: [
              // SPACE FOR DOCTOR IMAGE
              SizedBox(width: isSmallScreen ? 80 : 100),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Halo, Admin!\nSiap Bertugas Hari Ini?',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: isSmallScreen ? 13 : 14,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 4 : 6),
                    Text(
                      'Pantau transaksi hari ini dan kelola penjualan dengan lebih mudah dan cepat.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: isSmallScreen ? 10 : 11,
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),

          // DOCTOR IMAGE
          // DOCTOR IMAGE
          Positioned(
            bottom: isSmallScreen ? -8 : -12,
            left: isSmallScreen ? -10 : -14,
            child: Image.asset(
              'assets/dokter_card.png',
              height: isSmallScreen ? 100 : 120,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
