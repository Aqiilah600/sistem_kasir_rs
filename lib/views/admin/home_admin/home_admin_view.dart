import 'package:flutter/material.dart';
import '../../../models/dashboard_model.dart';
import '../widgets/admin_header.dart';
import '../widgets/admin_bottom_navbar.dart';
import 'widgets/welcome_admin_card.dart';
import 'widgets/kelola_layanan_card.dart';
import 'widgets/stat_card_rekapitulasi.dart';

// Ambil data dummy dari dashboard_model.dart
final List<DashboardStatistik> rekapitulasiHariIni = List.generate(
  3,
  (_) => getDummyDashboardStatistik(),
);

final List<DashboardStatistik> rekapitulasiBulanan = List.generate(
  3,
  (_) => getDummyDashboardStatistik(),
);

class HomeAdminView extends StatelessWidget {
  const HomeAdminView({super.key});

  // ICON MAPPING - HARDCODED DI VIEW
  final List<IconData> iconRekapitulasi = const [
    Icons.account_balance_wallet, // Total Pendapatan
    Icons.check_circle, // Jumlah Transaksi
    Icons.people, // Jumlah Pasien
  ];

  // LABEL MAPPING - untuk setiap card
  final List<String> labelRekapitulasi = const [
    'Total Pendapatan',
    'Jumlah Transaksi',
    'Jumlah Pasien',
  ];

  // Helper function untuk get value berdasarkan index
  String _getValue(DashboardStatistik data, int index) {
    switch (index) {
      case 0: // Total Pendapatan
        return 'Rp ${_formatRupiah(data.totalPendapatan)}';
      case 1: // Jumlah Transaksi
        return '${data.jumlahTransaksi} Transaksi';
      case 2: // Jumlah Pasien
        return '${data.jumlahPasien} Pasien';
      default:
        return '-';
    }
  }

  String _formatRupiah(num value) {
    final digits = value.toStringAsFixed(0).split('').reversed.toList();
    final chunks = <String>[];
    for (var i = 0; i < digits.length; i += 3) {
      chunks.add(digits.skip(i).take(3).join());
    }
    return chunks
        .map((chunk) => chunk.split('').reversed.join())
        .toList()
        .reversed
        .join('.');
  }

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

              // KELOLA LAYANAN CARD
              const KelolaLayananCard(),
              SizedBox(height: isSmallScreen ? 20 : 24),

              // REKAPITULASI LAYANAN HARI INI
              Text(
                'Rekapitulasi Layanan Hari Ini',
                style: TextStyle(
                  fontSize: isSmallScreen ? 13 : 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF005461),
                ),
              ),
              SizedBox(height: isSmallScreen ? 10 : 12),
              // ROW DENGAN LABEL & VALUE YANG TEPAT
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        label: labelRekapitulasi[index], // ← LABEL DYNAMIC
                        value: _getValue(
                          rekapitulasiHariIni[index],
                          index,
                        ), // ← VALUE DYNAMIC
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: isSmallScreen ? 20 : 24),

              // REKAPITULASI LAYANAN BULANAN
              Text(
                'Rekapitulasi Layanan Bulanan',
                style: TextStyle(
                  fontSize: isSmallScreen ? 13 : 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF005461),
                ),
              ),
              SizedBox(height: isSmallScreen ? 10 : 12),
              // ROW DENGAN LABEL & VALUE YANG TEPAT
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        label: labelRekapitulasi[index], // ← LABEL DYNAMIC
                        value: _getValue(
                          rekapitulasiBulanan[index],
                          index,
                        ), // ← VALUE DYNAMIC
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
