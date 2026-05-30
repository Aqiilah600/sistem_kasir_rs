import 'package:flutter/material.dart';
import '../widgets/kasir_bottom_navbar.dart';
import 'widgets/transaksi_data_pasien.dart';
import 'widgets/transaksi_payment.dart';
import 'widgets/transaksi_search.dart';
import 'widgets/transaksi_total.dart';
import '../widgets/kasir_header.dart';

class TransaksiView extends StatefulWidget {
  const TransaksiView({super.key});

  @override
  State<TransaksiView> createState() => _TransaksiViewState();
}

class _TransaksiViewState extends State<TransaksiView> {
  final TextEditingController searchController = TextEditingController();

  String selectedPayment = "Cash";

  final Map<String, String> data = {
    "ID Transaksi": "1003",
    "ID RM": "9921",
    "Pasien": "Hafis Ridho",
    "Tarif Dokter": "180.000",
    "Tarif Perawat": "80.000",
    "Subtotal Obat": "8.000",
    "Status": "Menunggu",
    "Tanggal": "2026-04-23",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const KasirHeader(),
      // BODY
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),

          child: Column(
            children: [
              // FIXED SEARCH
              TransaksiSearch(controller: searchController),

              const SizedBox(height: 14),

              // SCROLLABLE CONTENT
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // DATA PASIEN
                      TransaksiDataPasien(data: data),

                      const SizedBox(height: 14),

                      // METODE PEMBAYARAN
                      TransaksiPayment(
                        selectedPayment: selectedPayment,
                        onChanged: (value) {
                          setState(() {
                            selectedPayment = value;
                          });
                        },
                      ),

                      const SizedBox(height: 14),

                      // TOTAL PEMBAYARAN
                      const TransaksiTotal(),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // BOTTOM NAVBAR
      bottomNavigationBar: const KasirBottomNavbar(currentIndex: 2),
    );
  }
}
