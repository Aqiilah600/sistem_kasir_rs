import 'package:flutter/material.dart';
import '../../../models/kasir_acc_model.dart';

class EditAkunDialog extends StatefulWidget {
  final KasirAccount? account; // null jika tambah, ada data jika edit
  final Function(KasirAccount) onSave;

  const EditAkunDialog({super.key, this.account, required this.onSave});

  @override
  State<EditAkunDialog> createState() => _EditAkunDialogState();
}

class _EditAkunDialogState extends State<EditAkunDialog> {
  late TextEditingController namaController;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(
      text: widget.account?.namaKasir ?? '',
    );
    usernameController = TextEditingController(
      text: widget.account?.username ?? '',
    );
    emailController = TextEditingController(text: widget.account?.email ?? '');
    passwordController = TextEditingController(
      text: widget.account?.password ?? '',
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? _normalizePhotoUrl(String? url) {
    if (url == null || url.isEmpty) return null;
    if (url.startsWith('assets/')) return null;
    return url;
  }

  void _save() {
    final isEdit = widget.account != null;

    // Validasi
    if (namaController.text.isEmpty ||
        usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        (!isEdit && passwordController.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEdit
                ? 'Nama, username, dan email harus diisi!'
                : 'Semua field harus diisi!',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final account = KasirAccount(
      id: widget.account?.id ?? DateTime.now().toString(),
      namaKasir: namaController.text,
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text.isEmpty && isEdit
          ? widget.account!.password
          : passwordController.text,
      photoUrl: _normalizePhotoUrl(widget.account?.photoUrl),
    );

    widget.onSave(account);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.account != null;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isEdit ? 'Edit Akun Kasir' : 'Tambah Akun Kasir',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // NAMA KASIR
              const Text(
                'Nama Kasir',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: namaController,
                decoration: InputDecoration(
                  hintText: 'Muti Amelia',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // USERNAME
              const Text(
                'Username',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Kasir Mutia Amelia',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // EMAIL
              const Text(
                'Email',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'MutiaAmelia@kasir.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // PASSWORD
              const Text(
                'Password (kosongkan jika tidak diganti)',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'MutiaCantikImup',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // BUTTONS
              Row(
                children: [
                  // BATAL
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Batal',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // SIMPAN
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF005461),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Simpan',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
