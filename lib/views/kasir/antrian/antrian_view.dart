import 'package:flutter/material.dart';
import '../widgets/kasir_bottom_navbar.dart';
import 'widgets/stat_card.dart';
import 'widgets/dilewati_item.dart';
import 'widgets/sedang_dilayani_card.dart';
import '../widgets/kasir_header.dart';
import '../../../models/antrian_model.dart';
import 'widgets/antrian_item.dart';

class AntrianView extends StatefulWidget {
  const AntrianView({super.key});

  @override
  State<AntrianView> createState() => _AntrianViewState();
}

class _AntrianViewState extends State<AntrianView> {
  List<AntrianModel> antrianMenunggu = [
    AntrianModel(nomor: "03", nama: "Aulia", poli: "Poli Gigi"),
    AntrianModel(nomor: "04", nama: "Nurzaenni Aulia", poli: "Poli Gigi"),
    AntrianModel(nomor: "05", nama: "Mukaski", poli: "Poli Gigi"),
    AntrianModel(nomor: "06", nama: "Aji Jowair", poli: "Poli Gigi"),
  ];

  List<AntrianModel> antrianDilewati = [];
  List<AntrianModel> antrianSelesai = [];

  void selesaiDanLanjut() {
    if (antrianMenunggu.isEmpty) return;

    setState(() {
      antrianSelesai.add(antrianMenunggu.first);
      antrianMenunggu.removeAt(0);
    });
  }

  void skipAntrian() {
    if (antrianMenunggu.isEmpty) return;

    setState(() {
      antrianDilewati.add(antrianMenunggu.first);
      antrianMenunggu.removeAt(0);
    });
  }

  void panggilUlang(AntrianModel antrian) {
    setState(() {
      antrianDilewati.remove(antrian);
      antrianMenunggu.insert(0, antrian);
    });
  }

  Widget buildStatCard({
    required String label,
    required String count,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.3),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          StatCard(label: label, count: count, icon: icon, color: color),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: color.withAlpha((0.4 * 255).round()),
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          antrianMenunggu.isNotEmpty
              ? SedangDilayaniCard(
                  nomor: antrianMenunggu.first.nomor,
                  nama: antrianMenunggu.first.nama,
                  poli: antrianMenunggu.first.poli,
                  onSelesai: selesaiDanLanjut,
                  onSkip: skipAntrian,
                )
              : const SizedBox(),

          // KONTEN SCROLLABLE
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                const BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.3),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: StatCard(
                              label: 'Total Antrian',
                              count:
                                  '${antrianMenunggu.length + antrianDilewati.length + antrianSelesai.length}',
                              icon: Icons.people,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                const BoxShadow(
                                  color: Color(0x4D000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: StatCard(
                              label: 'Menunggu',
                              count: '${antrianMenunggu.length}',
                              icon: Icons.access_time,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                const BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.3),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: StatCard(
                              label: 'Sedang Dilayani',
                              count: '${antrianMenunggu.isNotEmpty ? 1 : 0}',
                              icon: Icons.headset_mic,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                const BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.3),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: StatCard(
                              label: 'Selesai',
                              count: '${antrianSelesai.length}',
                              icon: Icons.check_circle,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Daftar Antrian Pembayaran',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${antrianMenunggu.length} Menunggu',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          ...antrianMenunggu.map(
                            (antrian) => Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 45,
                                    height: 45,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.teal[700],
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      antrian.nomor,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          antrian.nama,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          antrian.poli,
                                          style: TextStyle(
                                            color: Colors.teal[300],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: antrian == antrianMenunggu.first
                                          ? Colors.teal.shade100
                                          : Colors.orange.shade100,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      antrian == antrianMenunggu.first
                                          ? 'Dipanggil'
                                          : 'Menunggu',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: antrian == antrianMenunggu.first
                                            ? Colors.teal
                                            : Colors.orange,
                                      ),
                                    ),
                                  ),

                                  IconButton(
                                    onPressed: () {
                                      showDetailAntrianDialog(
                                        context,
                                        nomor: antrian.nomor,
                                        nama: antrian.nama,
                                        poli: antrian.poli,
                                        status: antrian == antrianMenunggu.first
                                            ? 'Dipanggil'
                                            : 'Menunggu',
                                      );
                                    },
                                    icon: const Icon(Icons.visibility),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
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
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          child: Text(
                            '${antrianDilewati.length} Skip',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...antrianDilewati.map(
                      (antrian) => DilewatiItem(
                        nomor: antrian.nomor,
                        nama: antrian.nama,
                        poli: antrian.poli,
                        onPanggilUlang: () => panggilUlang(antrian),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const KasirBottomNavbar(currentIndex: 1),
    );
  }
}
