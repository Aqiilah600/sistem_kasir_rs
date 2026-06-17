import 'package:flutter/material.dart';
import '../../../../models/dashboard_model.dart';
import '../../../../utils/formatter.dart';
import '../widgets/kasir_bottom_navbar.dart';
import '../widgets/kasir_header.dart';
import 'widgets/welcome_card.dart';
import 'widgets/stat_card.dart';
import 'widgets/pendapatan_chart.dart';
import 'widgets/statistik_layanan_table.dart';

class HomeKasirView extends StatefulWidget {
  const HomeKasirView({super.key});

  @override
  State<HomeKasirView> createState() => _HomeKasirViewState();
}

class _HomeKasirViewState extends State<HomeKasirView> {
  late DashboardStatistik statistik;
  late List<PendapatanHarian> pendapatanMingguan;
  late List<LayananStatistik> statistikLayanan;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  void _loadDashboardData() {
    statistik = getDummyDashboardStatistik();
    pendapatanMingguan = getDummyPendapatanMingguan();
    statistikLayanan = getDummyStatistikLayanan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const KasirHeader(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // FIXED TOP AREA — dikecilkan agar grafik di bawah terlihat
                Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // WELCOME CARD — dikecilkan via constraints
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 120),
                        child: const WelcomeCard(),
                      ),
                      const SizedBox(height: 10),

                      // JUDUL — font lebih kecil
                      const Text(
                        'Rekapitulasi Layanan Hari Ini',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF006473),
                        ),
                      ),
                      const SizedBox(height: 6),

                      // STAT CARDS — IntrinsicHeight agar tinggi menyesuaikan konten
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: _buildStatCardWrapper(
                                child: StatCard(
                                  title: 'Total Pendapatan',
                                  value: formatRupiah(
                                    statistik.totalPendapatan,
                                  ),
                                  icon: Icons.account_balance_wallet,
                                  color: const Color(0xFF005461),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildStatCardWrapper(
                                child: StatCard(
                                  title: 'Jumlah Transaksi',
                                  value:
                                      '${statistik.jumlahTransaksi} Transaksi',
                                  icon: Icons.receipt_long,
                                  color: const Color(0xFF005461),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildStatCardWrapper(
                                child: StatCard(
                                  title: 'Jumlah Pasien',
                                  value: '${statistik.jumlahPasien} Pasien',
                                  icon: Icons.people,
                                  color: const Color(0xFF005461),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // SCROLLABLE — grafik & tabel
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      children: [
                        PendapatanChart(data: pendapatanMingguan),
                        const SizedBox(height: 10),
                        StatistikLayananTable(data: statistikLayanan),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: const KasirBottomNavbar(currentIndex: 0),
    );
  }

  Widget _buildStatCardWrapper({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
