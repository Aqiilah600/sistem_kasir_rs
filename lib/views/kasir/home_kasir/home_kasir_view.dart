import 'package:flutter/material.dart';
import '../../../models/dashboard_model.dart';
import '../../../utils/formatter.dart';
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

  // ============================================================
  // Pemuatan data dashboard.
  //
  // Saat ini menggunakan data dummy dari dashboard_model.dart.
  // Saat API tersedia, ganti isi method ini misalnya:
  //
  //   setState(() => isLoading = true);
  //   final res = await api.get('/kasir/dashboard');
  //   setState(() {
  //     statistik = DashboardStatistik.fromJson(res.data['statistik']);
  //     pendapatanMingguan = (res.data['pendapatan'] as List)
  //         .map((e) => PendapatanHarian.fromJson(e))
  //         .toList();
  //     statistikLayanan = (res.data['layanan'] as List)
  //         .map((e) => LayananStatistik.fromJson(e))
  //         .toList();
  //     isLoading = false;
  //   });
  // ============================================================
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
                // Fixed top area: welcome, title, stat cards
                Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const WelcomeCard(),
                      const SizedBox(height: 4),
                      const Text(
                        'Rekapitulasi Layanan Hari Ini',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF006473),
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        height: 112,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.20),
                                      blurRadius: 3,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
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
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.20),
                                      blurRadius: 3,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: StatCard(
                                  title: 'Jumlah Transaksi',
                                  value:
                                      '${statistik.jumlahTransaksi} Transaksi',
                                  icon: Icons.receipt_long,
                                  color: const Color(0xFF005461),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.20),
                                      blurRadius: 3,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
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

                // Scrollable content below
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
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
}
