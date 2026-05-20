import 'package:flutter/material.dart';

class TransaksiView extends StatefulWidget {
  const TransaksiView({super.key});

  @override
  State<TransaksiView> createState() => _TransaksiViewState();
}

class _TransaksiViewState extends State<TransaksiView> {
  final TextEditingController searchController = TextEditingController();

  // dummy data (nanti ganti API)
  Map<String, String> data = {
    "ID Transaksi": "1003",
    "ID Pasien": "550",
    "ID RM": "9921",
    "ID Antrian": "4",
    "Subtotal": "50.000",
    "Diskon": "0",
    "Pajak": "15.000",
    "Status": "-",
    "Tanggal": "2026-04-23",
  };

  String total = "105.000";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(title: const Text("Transaksi"), centerTitle: true),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Kelola transaksi pasien dengan mudah dan cepat.",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // SEARCH
            _card(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Input ID RM",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // DATA
            _card(
              child: Column(
                children: [
                  ...data.entries.map((e) => _field(e.key, e.value)),

                  const SizedBox(height: 10),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "Total Keseluruhan : ${data["Subtotal"]}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // METODE
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Metode Pembayaran",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  _radio("Cash"),
                  _radio("Kartu Debit"),
                  _radio("Transfer"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // TOTAL
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3EB7A6), Color(0xFF08828A)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    "Total Pembayaran",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Rp $total",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Transaksi dibatalkan"),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text("Batal"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Transaksi selesai"),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text("Selesaikan"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // CARD
  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  // FIELD
  Widget _field(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: title,
          hintText: value,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }

  // RADIO (dummy)
  Widget _radio(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.circle_outlined),
          const SizedBox(width: 10),
          Text(title),
        ],
      ),
    );
  }
}
