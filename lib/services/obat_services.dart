// Lokasi: lib/services/obat_service.dart
//
// Service layer untuk data obat.
// Ganti isi method di bawah dengan pemanggilan API saat tersedia —
// signature (Future<List<Obat>>) dibuat agar tidak perlu mengubah
// kode di DataObatView nantinya.

import '../models/obat_model.dart';

class ObatService {
  /// Ambil seluruh data obat.
  ///
  /// Contoh implementasi API nanti:
  /// ```dart
  /// Future<List<Obat>> getAllObat() async {
  ///   final res = await api.get('/obat');
  ///   return (res.data as List).map((e) => Obat.fromJson(e)).toList();
  /// }
  /// ```
  Future<List<Obat>> getAllObat() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return dummyObat;
  }

  /// Cari obat berdasarkan nama atau jenis (case-insensitive).
  ///
  /// Untuk versi API:
  /// ```dart
  /// Future<List<Obat>> searchObat(String query) async {
  ///   final res = await api.get('/obat', queryParameters: {'q': query});
  ///   return (res.data as List).map((e) => Obat.fromJson(e)).toList();
  /// }
  /// ```
  Future<List<Obat>> searchObat(String query) async {
    final all = await getAllObat();
    if (query.trim().isEmpty) return all;

    final lowerQuery = query.toLowerCase();
    return all.where((item) {
      return item.nama.toLowerCase().contains(lowerQuery) ||
          item.jenis.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
