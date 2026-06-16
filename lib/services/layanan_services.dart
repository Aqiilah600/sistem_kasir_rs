// Lokasi: lib/services/layanan_service.dart
//
// Service layer untuk data layanan medis.
// Saat ini mengembalikan data dummy. Ganti isi method di bawah
// dengan pemanggilan API saat sudah tersedia — signature method
// (return type Future<List<Layanan>>, dst) dibuat agar TIDAK PERLU
// mengubah kode di DataLayananView nantinya.

import '../views/models/layanan_model.dart';

class LayananService {
  /// Ambil seluruh data layanan.
  ///
  /// Contoh implementasi API nanti:
  /// ```dart
  /// Future<List<Layanan>> getAllLayanan() async {
  ///   final res = await api.get('/layanan');
  ///   return (res.data as List)
  ///       .map((e) => Layanan.fromJson(e))
  ///       .toList();
  /// }
  /// ```
  Future<List<Layanan>> getAllLayanan() async {
    // Simulasi delay network agar UI loading state bisa diuji.
    await Future.delayed(const Duration(milliseconds: 300));
    return dummyLayanan;
  }

  /// Cari layanan berdasarkan nama (case-insensitive).
  ///
  /// Untuk versi API, bisa diganti agar pencarian dilakukan di server:
  /// ```dart
  /// Future<List<Layanan>> searchLayanan(String query) async {
  ///   final res = await api.get('/layanan', queryParameters: {'q': query});
  ///   return (res.data as List).map((e) => Layanan.fromJson(e)).toList();
  /// }
  /// ```
  Future<List<Layanan>> searchLayanan(String query) async {
    final all = await getAllLayanan();
    if (query.trim().isEmpty) return all;

    final lowerQuery = query.toLowerCase();
    return all.where((item) {
      return item.nama.toLowerCase().contains(lowerQuery) ||
          item.kategori.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}