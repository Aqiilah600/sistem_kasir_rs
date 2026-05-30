import 'package:flutter/material.dart';
import '../home_kasir/home_kasir_view.dart';
import '../transaksi/transaksi_view.dart';

class KasirBottomNavbar extends StatelessWidget {
  final int currentIndex;

  const KasirBottomNavbar({super.key, required this.currentIndex});

  void _pushReplacementNoAnimation(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,

      currentIndex: currentIndex,

      selectedItemColor: Colors.grey[800],
      unselectedItemColor: const Color(0xFF005461),

      onTap: (index) {
        // JIKA TAB SAMA
        if (index == currentIndex) return;

        // HOME
        if (index == 0) {
          _pushReplacementNoAnimation(context, const HomeKasirView());
        }
        // ANTRIAN
        else if (index == 1) {
          // NANTI
        }
        // TRANSAKSI
        else if (index == 2) {
          _pushReplacementNoAnimation(context, const TransaksiView());
        }
        // LAINNYA
        else if (index == 3) {
          // NANTI
        }
      },

      items: const [
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage("assets/home.png"), size: 20),
          label: "Home",
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.format_list_bulleted),
          label: "Antrian",
        ),

        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage("assets/transaksi.png"), size: 20),
          label: "Transaksi",
        ),

        BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "Lainnya"),
      ],
    );
  }
}
