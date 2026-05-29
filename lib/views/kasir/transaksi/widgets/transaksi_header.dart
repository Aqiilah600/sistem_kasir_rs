import 'package:flutter/material.dart';
import '../../profile/profile_view.dart';

class TransaksiHeader extends StatelessWidget {
  const TransaksiHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TOP BAR
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/logo_rs.png", height: 30),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileView()),
                );
              },
              child: const CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage("assets/pfp_kasir.png"),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // TITLE
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Transaksi",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(height: 4),

        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Kelola transaksi pasien dengan mudah dan cepat.",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
