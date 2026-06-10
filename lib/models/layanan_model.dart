import 'package:flutter/material.dart';

class Layanan {
  final int id;
  final String nama;
  final String idLayanan;
  final IconData icon;
  final bool aktif;
  final int tarifDokter;
  final int tarifPerawat;
  final String kategori;

  Layanan({
    required this.id,
    required this.nama,
    required this.idLayanan,
    required this.icon,
    required this.aktif,
    required this.tarifDokter,
    required this.tarifPerawat,
    required this.kategori,
  });
}

// Dummy data
List<Layanan> dummyLayanan = [
  Layanan(
    id: 1,
    nama: 'Jantung',
    idLayanan: '101',
    icon: Icons.favorite,
    aktif: true,
    tarifDokter: 100000,
    tarifPerawat: 80000,
    kategori: 'Kardiologi',
  ),
  Layanan(
    id: 2,
    nama: 'Gigi',
    idLayanan: '102',
    icon: Icons.medical_services,
    aktif: true,
    tarifDokter: 150000,
    tarifPerawat: 50000,
    kategori: 'Dental',
  ),
  Layanan(
    id: 3,
    nama: 'Mata',
    idLayanan: '103',
    icon: Icons.remove_red_eye,
    aktif: true,
    tarifDokter: 120000,
    tarifPerawat: 60000,
    kategori: 'Oftalmologi',
  ),
  Layanan(
    id: 4,
    nama: 'Anak',
    idLayanan: '104',
    icon: Icons.child_care,
    aktif: true,
    tarifDokter: 100000,
    tarifPerawat: 70000,
    kategori: 'Pediatri',
  ),
];
