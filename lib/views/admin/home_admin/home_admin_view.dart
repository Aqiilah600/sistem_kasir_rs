import 'package:flutter/material.dart';
import '../../../models/rekapitulasi_model.dart';
import '../widgets/admin_bottom_navbar.dart';
import '../widgets/admin_header.dart';
import 'widgets/welcome_admin_card.dart';
import 'widgets/kelola_layanan_card.dart';
import 'widgets/stat_card_rekapitulasi.dart';

class HomeAdminView extends StatelessWidget {
  const HomeAdminView({super.key});

  // ICON MAPPING - HARDCODED DI VIEW
  final List<IconData> iconRekapitulasi = const [
    Icons.account_balance_wallet, // Total Pendapatan
    Icons.check_circle, // Jumlah Transaksi
    Icons.people, // Jumlah Pasien
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const AdminHeader(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 12 : 16,
            vertical: isSmallScreen ? 12 : 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // WELCOME CARD
              const WelcomeAdminCard(),
              SizedBox(height: isSmallScreen ? 12 : 16),

              //KELOLA LAYANAN CARD
              const KelolaLayananCard(),
              SizedBox(height: isSmallScreen ? 20 : 24),

              //REKAPITULASI LAYANAN HARI INI
              Text(
                'Rekapitulasi Layanan Hari Ini',
                style: TextStyle(
                  fontSize: isSmallScreen ? 13 : 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF005461),
                ),
              ),
              SizedBox(height: isSmallScreen ? 10 : 12),
              Row(
                children: List.generate(
                  rekapitulasiHariIni.length,
                  (index) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: index < rekapitulasiHariIni.length - 1
                            ? (isSmallScreen ? 8 : 10)
                            : 0,
                      ),
                      child: StatCardRekapitulasi(
                        data: rekapitulasiHariIni[index],
                        icon: iconRekapitulasi[index],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: isSmallScreen ? 20 : 24),

              //REKAPITULASI LAYANAN BULANAN
              Text(
                'Rekapitulasi Layanan Bulanan',
                style: TextStyle(
                  fontSize: isSmallScreen ? 13 : 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF005461),
                ),
              ),
              SizedBox(height: isSmallScreen ? 10 : 12),
              Row(
                children: List.generate(
                  rekapitulasiBulanan.length,
                  (index) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: index < rekapitulasiBulanan.length - 1
                            ? (isSmallScreen ? 8 : 10)
                            : 0,
                      ),
                      child: StatCardRekapitulasi(
                        data: rekapitulasiBulanan[index],
                        icon: iconRekapitulasi[index],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: isSmallScreen ? 20 : 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AdminBottomNavbar(currentIndex: 0),
    );
  }
}
