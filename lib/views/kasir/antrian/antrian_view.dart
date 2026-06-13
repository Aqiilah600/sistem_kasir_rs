import 'package:flutter/material.dart';
import '../../../models/antrian_model.dart';
import 'widgets/antrian_list_item.dart';
import 'widgets/detail_antrian_dialog.dart';
import 'widgets/panggil_ulang_dialog.dart';
import '../widgets/kasir_bottom_navbar.dart';
import '../widgets/kasir_header.dart';
import 'widgets/sedang_dilayani_card.dart';

class AntrianView extends StatefulWidget {
  const AntrianView({super.key});

  @override
  State<AntrianView> createState() => _AntrianViewState();
}

class _AntrianViewState extends State<AntrianView> {
  late List<AntriItem> allAntrian;
  AntriItem? sedangDilayani;
  late AntriStatistik statistik;
  bool semuaSelesai = false;

  @override
  void initState() {
    super.initState();
    _initializeAntrian();
  }

  void _initializeAntrian() {
    allAntrian = getInitialAntrian();
    if (allAntrian.isNotEmpty) {
      sedangDilayani = allAntrian.first.copyWith(status: 'Sedang Dilayani');
      allAntrian[0] = sedangDilayani!;
    }
    _updateStatistik();
  }

  void _updateStatistik() {
    statistik = AntriStatistik.fromList(allAntrian);
  }

  void _skipAntrian(AntriItem item) {
    setState(() {
      final index = allAntrian.indexWhere((e) => e.id == item.id);
      if (index != -1) {
        allAntrian[index] = allAntrian[index].copyWith(status: 'Dilewati');
      }

      if (sedangDilayani?.id == item.id) {
        final nextIndex = allAntrian.indexWhere((e) => e.status == 'Menunggu');
        if (nextIndex != -1) {
          sedangDilayani = allAntrian[nextIndex].copyWith(
            status: 'Sedang Dilayani',
          );
          allAntrian[nextIndex] = sedangDilayani!;
        } else {
          sedangDilayani = null;
          semuaSelesai = true;
        }
      }

      _updateStatistik();
    });
  }

  void _selesaiDanLanjut() {
    setState(() {
      final indexSekarang = allAntrian.indexWhere(
        (e) => e.status == 'Sedang Dilayani',
      );
      if (indexSekarang != -1) {
        allAntrian[indexSekarang] = allAntrian[indexSekarang].copyWith(
          status: 'Selesai',
        );
      }

      final indexBerikutnya = allAntrian.indexWhere(
        (e) => e.status == 'Menunggu',
      );
      if (indexBerikutnya != -1) {
        sedangDilayani = allAntrian[indexBerikutnya].copyWith(
          status: 'Sedang Dilayani',
        );
        allAntrian[indexBerikutnya] = sedangDilayani!;
      } else {
        sedangDilayani = null;
        semuaSelesai = true;
      }

      _updateStatistik();
    });
  }

  void _panggilUlang(AntriItem item) {
    setState(() {
      final index = allAntrian.indexWhere((e) => e.id == item.id);
      if (index != -1) {
        allAntrian[index] = allAntrian[index].copyWith(status: 'Menunggu');
      }

      if (semuaSelesai && sedangDilayani == null) {
        final nextIndex = allAntrian.indexWhere((e) => e.status == 'Menunggu');
        if (nextIndex != -1) {
          sedangDilayani = allAntrian[nextIndex].copyWith(
            status: 'Sedang Dilayani',
          );
          allAntrian[nextIndex] = sedangDilayani!;
          semuaSelesai = false;
        }
      }

      _updateStatistik();
    });
  }

  @override
  Widget build(BuildContext context) {
    final daftarAntrian = allAntrian
        .where((item) => item.status != 'Dilewati')
        .toList();
    final dilewati = allAntrian
        .where((item) => item.status == 'Dilewati')
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const KasirHeader(),
      body: Column(
        children: [
          // HEADER TETAP FIXED
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Antrian Kasir',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Kelola antrian pembayaran obat dan layanan',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          // SEDANG DILAYANI TETAP FIXED
          if (!semuaSelesai && sedangDilayani != null)
            SedangDilayaniCard(
              nomor: sedangDilayani!.nomor.toString().padLeft(2, '0'),
              nama: sedangDilayani!.nama,
              poli: sedangDilayani!.poli,
              onSelesai: _selesaiDanLanjut,
              onSkip: () => _skipAntrian(sedangDilayani!),
            )
          else if (semuaSelesai)
            Container(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.teal[600], size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Semua antrian telah selesai dilayani',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal[700],
                    ),
                  ),
                ],
              ),
            ),

          // SCROLLABLE CONTENT
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: Column(
                children: [
                  // STAT CARDS
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          label: 'Total Antrian',
                          count: statistik.totalAntrian.toString(),
                          icon: Icons.people,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildStatCard(
                          label: 'Menunggu',
                          count: statistik.menunggu.toString(),
                          icon: Icons.schedule,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          label: 'Sedang Dilayani',
                          count: statistik.sedangDilayani.toString(),
                          icon: Icons.headset_mic,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildStatCard(
                          label: 'Selesai',
                          count: statistik.selesai.toString(),
                          icon: Icons.check_circle,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // DAFTAR ANTRIAN PEMBAYARAN
                  if (daftarAntrian.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Daftar Antrian Pembayaran',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          child: Text(
                            '${statistik.menunggu} Menunggu',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...daftarAntrian.map(
                      (item) => AntriListItem(
                        item: item,
                        onDetailTap: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  DetailAntriDialog(item: item),
                            );
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // DILEWATI
                  if (dilewati.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Dilewati',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          child: Text(
                            '${dilewati.length} Skip',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...dilewati.map(
                      (item) => AntriListItem(
                        item: item,
                        onDetailTap: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            showDialog(
                              context: context,
                              builder: (context) => PanggilUlangDialog(
                                item: item,
                                onPanggilUlang: () => _panggilUlang(item),
                              ),
                            );
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const KasirBottomNavbar(currentIndex: 1),
    );
  }

  Widget _buildStatCard({
    required String label,
    required String count,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(26),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: Colors.black.withAlpha(56),
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              // circular icon with border
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // no border; fill the circle with a translucent version of the color
                  color: color.withAlpha(20),
                ),
                child: Center(child: Icon(icon, color: color, size: 18)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            count,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
