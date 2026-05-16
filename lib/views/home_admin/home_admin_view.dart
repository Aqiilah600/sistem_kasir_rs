import 'package:flutter/material.dart';
import 'widgets/welcome_admin_card.dart';

class HomeAdminView extends StatelessWidget {
  const HomeAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    // nanti ini bisa diganti dari API / state management
    final List<Map<String, dynamic>> transactions = [];

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Klinik App", style: TextStyle(color: Colors.black)),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              // nanti dari user profile
              backgroundColor: Colors.grey,
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
            const WelcomeAdminCard(),
            const SizedBox(height: 20),

            const Text(
              "Rekapitulasi Layanan Hari Ini",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // STAT CARD (belum ada data)
            const SizedBox(height: 20),

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
                },
              ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Pasien"),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: "Transaksi",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: "Lainnya",
          ),
        ],
      ),
    );
  }
}
