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
                Container(
                  height: 280,
                  color: Colors.white.withOpacity(0.5),
                ),

                // Logo kanan atas
                Positioned(
                  top: 50,
                  right: 20,
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        color: Colors.teal[200],
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Rumah Sakit",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Text(
                        "Vamedika",
                        style: TextStyle(
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // ================= CONTENT =================
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [

                  // TITLE
                  const Text(
                    "Selamat Datang!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Silahkan masuk untuk melanjutkan ke sistem.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ================= ROLE =================
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Masuk sebagai",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [

                      // KASIR
                      Expanded(
                        child: _roleCard(
                          icon: Icons.point_of_sale,
                          title: "Kasir",
                          subtitle:
                              "Kelola transaksi pembayaran pasien",
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

                  const SizedBox(height: 24),

                  // ================= EMAIL =================
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Masukkan Email",
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ================= PASSWORD =================
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Masukkan Kata Sandi",
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // ================= REMEMBER =================
                  Row(
                    children: [

                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),

                      const Text("Ingatkan Saya"),

                      const Spacer(),

                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Lupa Kata Sandi?",
                          style: TextStyle(
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ================= BUTTON =================
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.login),
                      label: const Text("Masuk"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Sistem Aman dan Terpercaya",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
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
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [

          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[200],
            child: Icon(
              icon,
              size: 30,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}