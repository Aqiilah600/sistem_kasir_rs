import 'package:flutter/material.dart';
import '../home_kasir/home_kasir_view.dart';
import '../transaksi/transaksi_view.dart';

class KasirBottomNavbar extends StatelessWidget {
  final int currentIndex;

  const KasirBottomNavbar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,

      currentIndex: currentIndex,

      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.grey,

      onTap: (index) {
        // JIKA TAB SAMA
        if (index == currentIndex) return;

        // HOME
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeKasirView()),
          );
        }
        // ANTRIAN
        else if (index == 1) {
          // NANTI
        }
        // TRANSAKSI
        else if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const TransaksiView()),
          );
        }
        // LAINNYA
        else if (index == 3) {
          // NANTI
        }
      },

      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

        BottomNavigationBarItem(
          icon: Icon(Icons.format_list_bulleted),
          label: "Antrian",
        ),

        BottomNavigationBarItem(icon: Icon(Icons.receipt), label: "Transaksi"),

        BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "Lainnya"),
      ],
    );
  }
}
