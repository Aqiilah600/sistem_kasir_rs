import 'package:flutter/material.dart';
import 'antrian_item.dart';

class DilewatiItem extends StatelessWidget {
  final String nomor;
  final String nama;
  final String poli;
  final VoidCallback onPanggilUlang;

  const DilewatiItem({
    super.key,
    required this.nomor,
    required this.nama,
    required this.poli,
    required this.onPanggilUlang,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              nomor,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  poli,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),

          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.visibility),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.notifications_active,
                              size: 50,
                              color: Colors.teal,
                            ),

                            const SizedBox(height: 16),

                            const Text(
                              "Panggil Ulang Antrian",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                            const SizedBox(height: 16),

                            AntrianItem(nomor: nomor, nama: nama, poli: poli),

                            const SizedBox(height: 16),

                            ElevatedButton(
                              onPressed: () {
                                onPanggilUlang();

                                Navigator.pop(context); // tutup dialog
                              },
                              child: const Text("Panggil Ulang"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
