import 'package:flutter/material.dart';
import '../home_kasir/home_kasir_view.dart';
import '../transaksi/transaksi_view.dart';
import '../antrian/antrian_view.dart';
import '../data_obat/data_obat_views.dart';
import '../data_layanan/data_layanan_view.dart';

class KasirBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final bool isLainnyaPage;

  const KasirBottomNavbar({
    super.key,
    required this.currentIndex,
    this.isLainnyaPage = false,
  });

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

  void _showLainnyaSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Wrap(
          spacing: 20,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            // DATA OBAT
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                _pushReplacementNoAnimation(context, const DataObatView());
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/obat.png",
                    width: 35,
                    height: 35,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.local_pharmacy,
                        size: 32,
                        color: const Color(0xFF005461),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  const Text('Data Obat', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),

            // DATA LAYANAN
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                _pushReplacementNoAnimation(context, const DataLayananView());
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/data_layanan.png",
                    width: 35,
                    height: 35,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.medical_services,
                        size: 32,
                        color: const Color(0xFF005461),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text('Data Layanan', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),

            // R. TRANSAKSI
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                _pushReplacementNoAnimation(context, const TransaksiView());
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/transaksi_history.png",
                    width: 32,
                    height: 32,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.history,
                        size: 32,
                        color: const Color(0xFF005461),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  const Text('R. Transaksi', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
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
        if (index == currentIndex && !isLainnyaPage) return;

        if (index == 0) {
          _pushReplacementNoAnimation(context, const HomeKasirView());
        } else if (index == 1) {
          _pushReplacementNoAnimation(context, const AntrianView());
        } else if (index == 2) {
          _pushReplacementNoAnimation(context, const TransaksiView());
        } else if (index == 3) {
          _showLainnyaSheet(context);
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
