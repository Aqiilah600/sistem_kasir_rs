import 'package:flutter/material.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoading = false;

  Future<void> _login() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email dan password wajib diisi")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (email == "admin" && password == "12345") {
      Navigator.pushReplacementNamed(context, "/home_admin");
    } else if (email == "kasir" && password == "1234") {
      Navigator.pushReplacementNamed(context, "/home_kasir");
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login gagal")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [
            //HEADER IMAGE
            Stack(
              children: [
                // Background image
                Container(
                  height: 340,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/login_img.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // gradient overlay
                Container(
                  height: 340,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(255, 255, 255, 0.0),
                        Color.fromRGBO(255, 255, 255, 1.0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 35,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Selamat Datang!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Silahkan masuk untuk melanjutkan ke sistem.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            //CONTENT
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  //ROLE
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Masuk sebagai",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      // KASIR
                      Expanded(
                        child: _roleCard(
                          icon: Icons.point_of_sale_sharp,
                          title: "Kasir",
                          subtitle: "Kelola transaksi pembayaran pasien",
                        ),
                      ),

                      const SizedBox(width: 12),

                      // ADMIN
                      Expanded(
                        child: _roleCard(
                          icon: Icons.admin_panel_settings,
                          title: "Admin Kasir",
                          subtitle:
                              "Kelola data, laporan, dan pengaturan kasir",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  //EMAIL
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Masukkan Email",
                      hintStyle: const TextStyle(color: Colors.blueGrey),

                      prefixIcon: const Icon(
                        Icons.email,
                        color: Color(0xFF08828A),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 12,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: const BorderSide(
                          color: Colors.teal,
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  //PASSWORD
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Masukkan Kata Sandi",
                      hintStyle: const TextStyle(color: Colors.blueGrey),

                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color(0xFF08828A),
                      ),

                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 12,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: const BorderSide(
                          color: Color(0xFF08828A),
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  //REMEMBER
                  Row(
                    children: [
                      // CHECKBOX
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: false,
                          onChanged: (value) {},

                          activeColor: Colors.teal,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),

                          side: BorderSide(color: Colors.grey.shade400),
                        ),
                      ),

                      const SizedBox(width: 10),

                      // TEXT
                      Text(
                        "Ingatkan Saya",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                        ),
                      ),

                      const Spacer(),

                      // FORGOT PASSWORD
                      TextButton(
                        onPressed: () {},

                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),

                        child: const Text(
                          "Lupa Kata Sandi?",
                          style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  //BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),

                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF08828A),
                            Color(0xFF339D9B),
                            Color(0xFF61BBAD),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),

                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(8, 130, 138, 0.3),
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),

                      child: ElevatedButton.icon(
                        onPressed: () => _login(),

                        icon: const Icon(Icons.login, color: Colors.white),

                        label: const Text(
                          "Masuk",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Sistem Aman dan Terpercaya",
                    style: TextStyle(color: Color(0xFF34526A), fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //ROLE CARD
  static Widget _roleCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[200],
            child: Icon(icon, size: 30, color: Colors.blueGrey),
          ),

          const SizedBox(height: 12),

          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

          const SizedBox(height: 8),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
