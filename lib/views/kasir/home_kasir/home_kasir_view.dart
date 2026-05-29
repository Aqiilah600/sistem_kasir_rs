import 'package:flutter/material.dart';
import '../widgets/kasir_bottom_navbar.dart';
import 'widgets/welcome_card.dart';
import 'widgets/stat_card.dart';
import 'widgets/transaction_item.dart';
import 'widgets/section_header.dart';
import '../profile/profile_view.dart';

class HomeKasirView extends StatefulWidget {
  const HomeKasirView({super.key});

  @override
  State<HomeKasirView> createState() => _HomeKasirViewState();
}

class _HomeKasirViewState extends State<HomeKasirView> {
  // removed unused _selectedIndex field

  @override
  Widget build(BuildContext context) {
    // nanti ini bisa diganti dari API / state management
    final List<Map<String, dynamic>> transactions = [];

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: Image.asset("assets/logo_rs2.png", height: 30),

        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileView()),
                );
              },
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/pfp_kasir.png"),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // WELCOME CARD
            const WelcomeCard(),

            const SizedBox(height: 20),

            const Text(
              "Rekapitulasi Layanan Hari Ini",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // STAT CARD (belum ada data)
            const Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: "Total Pendapatan",
                    value: "-",
                    icon: Icons.wallet_rounded,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: StatCard(
                    title: "Jumlah Transaksi",
                    value: "-",
                    icon: Icons.receipt_long,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: StatCard(
                    title: "Jumlah Pasien",
                    value: "-",
                    icon: Icons.people,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const SectionHeader(),

            const SizedBox(height: 12),

            // LIST TRANSAKSI (dinamis)
            if (transactions.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Belum ada transaksi",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final trx = transactions[index];

                  return TransactionItem(
                    title: trx['title'],
                    price: trx['price'],
                    date: trx['date'],
                  );
                },
              ),
          ],
        ),
      ),

      bottomNavigationBar: const KasirBottomNavbar(currentIndex: 0),
    );
  }
}
