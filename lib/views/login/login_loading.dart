// Lokasi: lib/views/login/widgets/login_loading_view.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginLoading extends StatelessWidget {
  const LoginLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan warna transparan agar latar belakang login tetap terlihat samar
      backgroundColor: Colors.black.withOpacity(0.3),
      body: Stack(
        children: [
          // Efek blur pada latar belakang halaman login
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: const SizedBox(),
            ),
          ),
          // Konten Utama Animasi Lottie
          Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'assets/loading_lazy.json',
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Menghubungkan ke Server...",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF005461),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
