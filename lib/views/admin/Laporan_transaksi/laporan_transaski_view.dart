import 'package:flutter/material.dart';
import '../widgets/admin_header.dart';
import '../widgets/admin_bottom_navbar.dart';
import '../../../../models/transaksi_model.dart';
import 'widgets/transaksi_summary_card.dart';
import 'widgets/tabel_transaksi.dart';

class LaporanTransaksiView extends StatefulWidget {
  const LaporanTransaksiView({super.key});

  @override
  State<LaporanTransaksiView> createState() => _LaporanTransaksiViewState();
}

class _LaporanTransaksiViewState extends State<LaporanTransaksiView> {
  late List<Transaksi> allTransactions;
  late List<Transaksi> filteredTransactions;
  late DateTime tanggalMulai;
  late DateTime tanggalAkhir;

  @override
  void initState() {
    super.initState();
    allTransactions = getDummyTransaksiList();
    tanggalMulai = DateTime(2026, 1, 1);
    tanggalAkhir = DateTime(2026, 1, 31);
    _filterTransactions();
  }

  void _filterTransactions() {
    setState(() {
      filteredTransactions = allTransactions.where((transaction) {
        final transactionDate = DateTime.parse(transaction.tanggal);
        return transactionDate.isAfter(
              tanggalMulai.subtract(const Duration(days: 1)),
            ) &&
            transactionDate.isBefore(tanggalAkhir.add(const Duration(days: 1)));
      }).toList();
    });
  }

  Future<void> _selectStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: tanggalMulai,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != tanggalMulai) {
      setState(() {
        tanggalMulai = picked;
        _filterTransactions();
      });
    }
  }

  Future<void> _selectEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: tanggalAkhir,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != tanggalAkhir) {
      setState(() {
        tanggalAkhir = picked;
        _filterTransactions();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const AdminHeader(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              const Text(
                'Laporan Transaksi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Lihat ringkasan transaksi kasir berdasarkan periode yang terpilih',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(height: 20),

              // DATE RANGE PICKER
              Row(
                children: [
                  // TANGGAL MULAI
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tanggal Mulai',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: _selectStartDate,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF005461),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formatDate(tanggalMulai),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Icon(
                                  Icons.calendar_today,
                                  size: 18,
                                  color: Color(0xFF005461),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),

                  // TANGGAL AKHIR
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tanggal Akhir',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: _selectEndDate,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF005461),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formatDate(tanggalAkhir),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Icon(
                                  Icons.calendar_today,
                                  size: 18,
                                  color: Color(0xFF005461),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // FILTER BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _filterTransactions,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3AC0A8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.filter_list, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Filter',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // RINGKASAN SECTION
              const Text(
                'Ringkasan',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF005461),
                ),
              ),
              const SizedBox(height: 12),

              // STAT CARDS GRID
              GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  TransactionSummaryCard(
                    label: 'Total Transaksi',
                    transaksi: Transaksi(
                      idTransaksi: '',
                      idRm: '',
                      namaPasien: '',
                      tarifDokter: filteredTransactions.fold(
                        0.0,
                        (sum, e) => sum + e.tarifDokter,
                      ),
                      tarifPerawat: 0,
                      subtotalObat: 0,
                      status: '',
                      tanggal: '',
                      noInvoice: '',
                      daftarObat: [],
                      daftarLayanan: [],
                    ),
                    valueBuilder: (t) => t.tarifDokter,
                    icon: Icons.shopping_cart,
                    iconColor: const Color(0xFF3AC0A8),
                  ),
                  TransactionSummaryCard(
                    label: 'Pendapatan Obat',
                    transaksi: Transaksi(
                      idTransaksi: '',
                      idRm: '',
                      namaPasien: '',
                      tarifDokter: 0,
                      tarifPerawat: 0,
                      subtotalObat: filteredTransactions.fold(
                        0.0,
                        (sum, e) => sum + e.totalObat,
                      ),
                      status: '',
                      tanggal: '',
                      noInvoice: '',
                      daftarObat: [],
                      daftarLayanan: [],
                    ),
                    valueBuilder: (t) => t.subtotalObat,
                    icon: Icons.local_pharmacy,
                    iconColor: Colors.blue,
                  ),
                  TransactionSummaryCard(
                    label: 'Pendapatan Layanan',
                    transaksi: Transaksi(
                      idTransaksi: '',
                      idRm: '',
                      namaPasien: '',
                      tarifDokter: 0,
                      tarifPerawat: filteredTransactions.fold(
                        0.0,
                        (sum, e) => sum + e.totalLayanan,
                      ),
                      subtotalObat: 0,
                      status: '',
                      tanggal: '',
                      noInvoice: '',
                      daftarObat: [],
                      daftarLayanan: [],
                    ),
                    valueBuilder: (t) => t.tarifPerawat,
                    icon: Icons.medical_services,
                    iconColor: Colors.purple,
                  ),
                  TransactionSummaryCard(
                    label: 'Total Pendapatan',
                    transaksi: Transaksi(
                      idTransaksi: '',
                      idRm: '',
                      namaPasien: '',
                      tarifDokter: 0,
                      tarifPerawat: 0,
                      subtotalObat: 0,
                      status: '',
                      tanggal: '',
                      noInvoice: '',
                      daftarObat: [],
                      daftarLayanan: [],
                    ),
                    valueBuilder: (t) => filteredTransactions.fold(
                      0.0,
                      (sum, e) => sum + e.totalKeseluruhan,
                    ),
                    icon: Icons.attach_money,
                    iconColor: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // TRANSACTION TABLE SECTION
              const Text(
                'Detail Transaksi',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF005461),
                ),
              ),
              const SizedBox(height: 12),
              TransactionTable(transactions: filteredTransactions),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AdminBottomNavbar(currentIndex: 1),
    );
  }
}
