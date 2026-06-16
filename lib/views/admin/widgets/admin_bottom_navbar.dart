import 'package:flutter/material.dart';
import '../home_admin/home_admin_view.dart';
import '../kelola_akun/kelola_akun_view.dart';
// import '../Laporan_transaksi/laporan_transaski_view.dart';

class AdminBottomNavbar extends StatelessWidget {
  final int currentIndex;

  const AdminBottomNavbar({super.key, required this.currentIndex});

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
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xFF005461),
      unselectedItemColor: Colors.grey[400],
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 8,
      onTap: (index) {
        if (index == currentIndex) return;

        if (index == 0) {
          _pushReplacementNoAnimation(context, const HomeAdminView());
        } else if (index == 1) {
          //_pushReplacementNoAnimation(context, const LaporanTransaksiView());
        } else if (index == 2) {
          _pushReplacementNoAnimation(context, const KelolaAkunView());
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt),
          label: 'Laporan Transaksi',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Kelola Akun'),
      ],
    );
  }
}
