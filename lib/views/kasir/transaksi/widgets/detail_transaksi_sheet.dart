import 'package:flutter/material.dart';

class DetailTransaksiSheet extends StatelessWidget {
  const DetailTransaksiSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Colors.white),

      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              children: [
                const Icon(Icons.receipt_long, color: Colors.teal),
                const SizedBox(width: 8),
                const Text(
                  "Detail Transaksi",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(),

            // INFO ATAS
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: const Color(0xFFCCCCCC)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _infoItem("No Invoice", "INV-2026/001-001"),
                        _infoItem("Pasien", "Hafis Ridho"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: _infoItem("Tanggal", "24/05/2026"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Align(
              alignment: Alignment.centerLeft,
              child: _infoItem("Tanggal", "24/05/2026"),
            ),

            const SizedBox(height: 16),

            // ================= OBAT =================
            _sectionTitle("Daftar Obat"),
            _tableHeader(),
            _tableRow("Cafodixil 500mg", "2", "Rp 15.000", "Rp 30.000"),
            _tableRow("Enervon-C", "3", "Rp 18.000", "Rp 54.000"),

            const SizedBox(height: 6),

            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Total Obat : Rp 84.000",
                style: TextStyle(
                  color: Color(0xFF007F93),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ================= LAYANAN =================
            _sectionTitle("Daftar Layanan"),
            _tableHeader(),
            _tableRow("Jantung", "2", "Rp 180.000", "Rp 180.000"),

            const SizedBox(height: 6),

            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Total Layanan : Rp 180.000",
                style: TextStyle(
                  color: Color(0xFF007F93),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _infoItem extends StatelessWidget {
  final String title;
  final String value;

  const _infoItem(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.black, fontSize: 12)),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF007F93),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

Widget _sectionTitle(String title) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF007F93),
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _tableHeader() {
  return Container(
    padding: const EdgeInsets.all(8),
    color: Color(0xFF007F93),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Expanded(
          child: Text("Nama", style: TextStyle(color: Colors.white)),
        ),
        Expanded(
          child: Text("Jumlah", style: TextStyle(color: Colors.white)),
        ),
        Expanded(
          child: Text("Harga", style: TextStyle(color: Colors.white)),
        ),
        Expanded(
          child: Text("Subtotal", style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}

Widget _tableRow(String nama, String jumlah, String harga, String subtotal) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(nama)),
        Expanded(child: Text(jumlah)),
        Expanded(child: Text(harga)),
        Expanded(child: Text(subtotal)),
      ],
    ),
  );
}
