import 'package:flutter/material.dart';
import 'widgets/obat_header.dart';
import 'widgets/obat_search.dart';
import 'widgets/obat_card.dart';
import '../widgets/kasir_bottom_navbar.dart';
import '../widgets/kasir_header.dart';

class DataObatView extends StatefulWidget {
  const DataObatView({super.key});

  @override
  State<DataObatView> createState() => _DataObatViewState();
}

class _DataObatViewState extends State<DataObatView> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> obatList = [
      {
        "nama": "Cefadroxil 500mg",
        "jenis": "Antibiotik",
        "stok": "80",
        "harga": "15.000",
        "exp": "08/05/2027",
      },
      {
        "nama": "Myanta Cair 60ml",
        "jenis": "Antasida",
        "stok": "45",
        "harga": "18.000",
        "exp": "07/07/2027",
      },
      {
        "nama": "Bodrex Migra",
        "jenis": "Analgesik",
        "stok": "65",
        "harga": "8.500",
        "exp": "07/06/2027",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const KasirHeader(),

      bottomNavigationBar: const KasirBottomNavbar(
        currentIndex: 3,
        isLainnyaPage: true,
      ),

      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [ObatHeader(), SizedBox(height: 20), ObatSearch()],
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: obatList.length,
                itemBuilder: (context, index) {
                  final obat = obatList[index];

                  return ObatCard(
                    nama: obat["nama"]!,
                    jenis: obat["jenis"]!,
                    stok: obat["stok"]!,
                    harga: obat["harga"]!,
                    exp: obat["exp"]!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
