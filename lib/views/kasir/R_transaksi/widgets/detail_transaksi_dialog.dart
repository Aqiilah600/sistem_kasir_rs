import 'package:flutter/material.dart';

class DetailTransaksiDialog extends StatelessWidget {
  final Map<String, dynamic> transaksi;

  const DetailTransaksiDialog({super.key, required this.transaksi});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Dialog Atas
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFFEBF7F7),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.assignment_outlined, color: Color(0xFF007A87), size: 20),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Detail Transaksi',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2F7E2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Lunas',
                            style: TextStyle(color: Colors.green, fontSize: 9, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.grey, size: 20),
                  )
                ],
              ),
              const Divider(height: 20),

              // Bagian Identitas Atas (2 baris x 2 kolom)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2.5,
                  children: [
                    _buildMetaItem(Icons.receipt_outlined, 'No Invoice', transaksi['invoice']),
                    _buildMetaItem(Icons.people_outline, 'Pasien', transaksi['pasien']),
                    _buildMetaItem(Icons.calendar_month_outlined, 'Tanggal', transaksi['tanggal']),
                    _buildMetaItem(Icons.account_balance_wallet_outlined, 'Metpay', transaksi['metode']),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 1. DAFTAR OBAT (Seksi Tabel Pertama)
              _buildSectionHeader(Icons.link, 'Daftar Obat'),
              const SizedBox(height: 6),
              _buildTable(
                headers: ['Nama Obat', 'Jumlah', 'Harga Satuan', 'Subtotal'],
                rows: [
                  ['Cafadroxil 500mg', '2', 'Rp 15.000', 'Rp 30.000'],
                  ['Enervon-c', '3', 'Rp 18.000', 'Rp 54.000'],
                ],
                totalLabel: 'Total Obat',
                totalValue: 'Rp 84.000',
              ),
              const SizedBox(height: 16),

              // 2. DAFTAR LAYANAN (Seksi Tabel Kedua)
              _buildSectionHeader(Icons.medical_services_outlined, 'Daftar Layanan'),
              const SizedBox(height: 6),
              _buildTable(
                headers: ['Nama Layanan', 'Jumlah', 'Tarif', 'Subtotal'],
                rows: [
                  ['Jantung', '2', 'Rp 180.000', 'Rp 180.000'],
                ],
                totalLabel: 'Total Layanan',
                totalValue: 'Rp 180.000',
              ),
              const SizedBox(height: 16),

              // 3. RINGKASAN PEMBAYARAN KOTAK BAWAH
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[200]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.payment, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 6),
                        const Text('Ringkasan Pembayaran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                      ],
                    ),
                    const Divider(height: 16),
                    _buildSummaryRow('Subtotal Obat', 'Rp 84.000', 'Dibayar', 'Rp 270.000'),
                    const SizedBox(height: 4),
                    _buildSummaryRow('Subtotal Layanan', 'Rp 180.000', 'Kembalian', 'Rp 6.000'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Bayar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        Text(
                          'Rp 264.000',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.teal[700]),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Tombol Tutup Paling Bawah
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007A87),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Tutup', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Builder Item Informasi Ringkas Invoice/Pasien
  Widget _buildMetaItem(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(radius: 12, backgroundColor: Colors.grey[100], child: Icon(icon, size: 12, color: Colors.grey[600])),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey)),
              Text(
                value,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF005461)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF007A87)),
        const SizedBox(width: 4),
        Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF007A87))),
      ],
    );
  }

  // Builder Tabel Fleksibel untuk Data Obat dan Data Layanan
  Widget _buildTable({
    required List<String> headers,
    required List<List<String>> rows,
    required String totalLabel,
    required String totalValue,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          // Row Header Tabel dengan Background Teal Gelap
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF007A87),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            ),
            padding: const EdgeInsets.all(6),
            child: Row(
              children: headers.map((h) => Expanded(
                child: Text(
                  h,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 9),
                ),
              )).toList(),
            ),
          ),
          // Baris Isi Tabel
          Column(
            children: rows.map((row) => Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
              child: Row(
                children: row.map((cell) => Expanded(
                  child: Text(
                    cell,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10),
                  ),
                )).toList(),
              ),
            )).toList(),
          ),
          // Total Baris Bawah Tabel
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('$totalLabel : ', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF007A87))),
                Text(totalValue, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF007A87))),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String labelLeft, String valueLeft, String labelRight, String valueRight) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(labelLeft, style: const TextStyle(fontSize: 10, color: Colors.grey)),
              Text(valueLeft, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(labelRight, style: const TextStyle(fontSize: 10, color: Colors.grey)),
              Text(valueRight, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }
}