import 'package:flutter/material.dart';
import '../profile/profile_view.dart';

class AdminHeader extends StatelessWidget implements PreferredSizeWidget {
  const AdminHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
            child: const CircleAvatar(
              backgroundImage: AssetImage("assets/pfp_admin.png"),
            ),
          ),
        ),
      ],
    );
  }
}