// Lokasi: lib/models/layanan_model.dart

import 'package:flutter/material.dart';

class Layanan {
  final int idLayanan;
  final String nama;
  final String iconName; // disimpan sebagai String agar API-friendly
  final bool aktif;
  final int tarifDokter;
  final int tarifPerawat;
  final String kategori;

  Layanan({
    required this.idLayanan,
    required this.nama,
    required this.iconName,
    required this.aktif,
    required this.tarifDokter,
    required this.tarifPerawat,
    required this.kategori,
  });

  /// IconData turunan dari [iconName], dipakai oleh UI (LayananItem).
  IconData get icon => iconFromName(iconName);

  factory Layanan.fromJson(Map<String, dynamic> json) {
    return Layanan(
      idLayanan: json['id_layanan'] as int,
      nama: json['nama'] as String,
      iconName: json['icon_name'] as String? ?? 'default',
      aktif: json['aktif'] as bool? ?? true,
      tarifDokter: (json['tarif_dokter'] as num?)?.toInt() ?? 0,
      tarifPerawat: (json['tarif_perawat'] as num?)?.toInt() ?? 0,
      kategori: json['kategori'] as String? ?? '-',
    );
  }

  Map<String, dynamic> toJson() => {
    'id_layanan': idLayanan,
    'nama': nama,
    'icon_name': iconName,
    'aktif': aktif,
    'tarif_dokter': tarifDokter,
    'tarif_perawat': tarifPerawat,
    'kategori': kategori,
  };
}

/// Pemetaan nama icon (String, dari API) ke IconData (Flutter).
/// Tambahkan case baru di sini kalau ada kategori layanan baru dari API.
IconData iconFromName(String name) {
  switch (name) {
    case 'gigi':
      return Icons.medical_services;
    case 'jantung':
      return Icons.favorite;
    case 'mata':
      return Icons.visibility;
    case 'umum':
      return Icons.local_hospital;
    default:
      return Icons.medical_services_outlined;
  }
}

// ============================================================
// DUMMY DATA — Hapus / ganti dengan LayananService.getAllLayanan()
// saat API tersedia.
// ============================================================
final List<Layanan> dummyLayanan = [
  Layanan(
    idLayanan: 1,
    nama: 'Pemeriksaan Gigi',
    iconName: 'gigi',
    aktif: true,
    tarifDokter: 100000,
    tarifPerawat: 50000,
    kategori: 'Poli Gigi',
  ),
  Layanan(
    idLayanan: 2,
    nama: 'Konsultasi Jantung',
    iconName: 'jantung',
    aktif: true,
    tarifDokter: 200000,
    tarifPerawat: 75000,
    kategori: 'Poli Jantung',
  ),
  Layanan(
    idLayanan: 3,
    nama: 'Pemeriksaan Mata',
    iconName: 'mata',
    aktif: true,
    tarifDokter: 150000,
    tarifPerawat: 60000,
    kategori: 'Poli Mata',
  ),
  Layanan(
    idLayanan: 4,
    nama: 'Pemeriksaan Umum',
    iconName: 'umum',
    aktif: true,
    tarifDokter: 80000,
    tarifPerawat: 40000,
    kategori: 'Poli Umum',
  ),
];
