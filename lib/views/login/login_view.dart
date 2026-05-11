import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= HEADER IMAGE =================
            Stack(
              children: [
                // Background image nanti
                Container(
                  height: 280,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Text(
                      "HEADER IMAGE",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),

                // Overlay putih transparan
                Container(height: 280, color: Colors.white.withOpacity(0.5)),
              ],
            ),

            // ================= CONTENT =================
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  // TITLE
                  const Text(
                    "Selamat Datang!",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 2),

                  const Text(
                    "Silahkan masuk untuk melanjutkan ke sistem.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blueGrey),
                  ),

                  const SizedBox(height: 30),

                  // ================= ROLE =================
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

                  // ================= EMAIL =================
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Masukkan Email",
                      hintStyle: const TextStyle(color: Colors.blueGrey),
                      prefixIcon: const Icon(Icons.email, color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ================= PASSWORD =================
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Masukkan Kata Sandi",
                      hintStyle: const TextStyle(color: Colors.blueGrey),
                      prefixIcon: const Icon(Icons.lock, color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // ================= REMEMBER =================
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

                  const SizedBox(height: 24),

                  // ================= BUTTON =================
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),

                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 2, 106, 130),
                            Colors.teal,
                            Color(0xFF4DB6AC),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),

                      child: ElevatedButton.icon(
                        onPressed: () {},

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

  // ================= ROLE CARD =================
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
