import 'package:flutter/material.dart';
import '../../../models/rekapitulasi_model.dart';
import 'widgets/welcome_admin_card.dart';
import 'widgets/kelola_layanan_card.dart';
import 'widgets/stat_card_rekapitulasi.dart';

class HomeAdminView extends StatelessWidget {
  const HomeAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset("assets/logo_rs2.png", height: 30),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/pfp_admin.png"),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ WELCOME CARD
            const WelcomeAdminCard(),
            const SizedBox(height: 16),

            // ✅ KELOLA LAYANAN CARD
            const KelolaLayananCard(),
            const SizedBox(height: 24),

            // ✅ REKAPITULASI LAYANAN HARI INI
            const Text(
              'Rekapitulasi Layanan Hari Ini',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: rekapitulasiHariIni
                  .map((data) => StatCardRekapitulasi(data: data))
                  .toList(),
            ),
            const SizedBox(height: 24),

            // ✅ REKAPITULASI LAYANAN BULANAN
            const Text(
              'Rekapitulasi Layanan Bulanan',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: rekapitulasiBulanan
                  .map((data) => StatCardRekapitulasi(data: data))
                  .toList(),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Color(0xFF005461),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Laporan Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Kelola Akun',
          ),
        ],
      ),
    );
  }
}
