import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  final bool isSmallScreen;

  const WelcomeCard({Key? key, this.isSmallScreen = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 14 : 16,
              vertical: isSmallScreen ? 12 : 14,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF3BC1A8),
                  Color(0xFF007F93),
                  Color(0xFF005461),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: isSmallScreen ? 70 : 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Kelola Akun Kasir',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallScreen ? 13 : 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Kelola data akun kasir yang akan dapat mengakses sistem.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: isSmallScreen ? 10 : 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: isSmallScreen ? -12 : -16,
                  top: isSmallScreen ? -16 : -20,
                  left: isSmallScreen ? -12 : -16,
                  child: Image.asset(
                    'assets/dokter_card.png',
                    height: isSmallScreen ? 100 : 120,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
