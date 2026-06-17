import 'package:flutter/material.dart';
import '../widgets/admin_header.dart';
import '../widgets/admin_bottom_navbar.dart';
import '../../../models/kasir_acc_model.dart';
import 'widgets/welcome_card.dart';
import 'widgets/kasir_acc_card.dart';
import 'widgets/edit_akun_dialog.dart';

class KelolaAkunView extends StatefulWidget {
  const KelolaAkunView({super.key});

  @override
  State<KelolaAkunView> createState() => _KelolaAkunViewState();
}

class _KelolaAkunViewState extends State<KelolaAkunView> {
  late List<KasirAccount> kasirAccounts;

  @override
  void initState() {
    super.initState();
    // Load dummy data
    kasirAccounts = getDummyKasirAccounts();
  }

  // TAMBAH AKUN
  void _addAccount(KasirAccount account) {
    setState(() {
      kasirAccounts.add(account);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Akun berhasil ditambahkan'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // EDIT AKUN
  void _editAccount(KasirAccount updatedAccount) {
    setState(() {
      final index = kasirAccounts.indexWhere((e) => e.id == updatedAccount.id);
      if (index != -1) {
        kasirAccounts[index] = updatedAccount;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Akun berhasil diperbarui'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // HAPUS AKUN
  void _deleteAccount(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Akun'),
        content: const Text('Apakah Anda yakin ingin menghapus akun ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                kasirAccounts.removeWhere((e) => e.id == id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Akun berhasil dihapus'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const AdminHeader(),
      body: Column(
        children: [
          const WelcomeCard(),
          SizedBox(height: isSmallScreen ? 12 : 16),
          // LIST AKUN
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LIST TITLE & COUNT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Daftar Kasir',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 13 : 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF005461),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF005461),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${kasirAccounts.length} Kasir',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // KASIR LIST
                  ...kasirAccounts.map(
                    (account) => KasirAccountCard(
                      account: account,
                      onEdit: () {
                        showDialog(
                          context: context,
                          builder: (context) => EditAkunDialog(
                            account: account,
                            onSave: _editAccount,
                          ),
                        );
                      },
                      onDelete: () => _deleteAccount(account.id),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      // FLOATING ACTION BUTTON - TAMBAH AKUN
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => EditAkunDialog(onSave: _addAccount),
          );
        },
        backgroundColor: const Color(0xFF005461),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: const AdminBottomNavbar(currentIndex: 2),
    );
  }
}
