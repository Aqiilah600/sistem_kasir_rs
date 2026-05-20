import 'package:flutter/material.dart';
import 'package:sistem_kasir_rs/views/admin/home_admin/home_admin_view.dart';
import 'package:sistem_kasir_rs/views/kasir/home_kasir/home_kasir_view.dart';
import 'package:sistem_kasir_rs/views/login/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",

      routes: {
        "/": (context) => const LoginView(),
        "/home_admin": (context) => const HomeAdminView(),
        "/home_kasir": (context) => const HomeKasirView(),
      },
    );
  }
}
