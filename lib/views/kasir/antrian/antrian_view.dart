import 'package:flutter/material.dart';
import '../widgets/kasir_bottom_navbar.dart';
import 'widgets/stat_card.dart';
import 'widgets/dilewati_item.dart';
import 'widgets/sedang_dilayani_card.dart';
import '../widgets/kasir_header.dart';
import '../../../models/antrian_model.dart';

class AntrianView extends StatefulWidget {
  const AntrianView({super.key});

  @override
  State<AntrianView> createState() => _AntrianViewState();
}

class _AntrianViewState extends State<AntrianView> {
  List<AntrianModel> antrianMenunggu = [
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

      // Langsung jadi antrian berikutnya
      antrianMenunggu.insert(0, antrian);

      // Kalau mau masuk paling belakang:
      // antrianMenunggu.add(antrian);
    });
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
                    StatCard(
                      label: 'Total Antrian',
                      count: '12',
                      icon: Icons.people,
                      color: Colors.teal,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            label: 'Menunggu',
                            count: '7',
                            icon: Icons.schedule,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            label: 'Sedang Dilayani',
                            count: '2',
                            icon: Icons.person,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            label: 'Selesai',
                            count: '2',
                            icon: Icons.check_circle,
                            color: Colors.purple,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            label: 'Dilewati',
                            count: '1',
                            icon: Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
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
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          child: const Text(
                            '7 Menunggu',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
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
                          child: const Text(
                            '1 Skip',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    DilewatiItem(
                      nomor: '03',
                      nama: 'Aulia',
                      poli: 'Poli Gigi',
                      onPanggilUlang: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.refresh),
                                  title: const Text('Panggil ulang Aulia'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
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
