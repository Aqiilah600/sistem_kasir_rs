// Lokasi: lib/services/transaksi_service.dart

import '../../../models/transaksi_model.dart';

class TransaksiService {
  /// Cari transaksi berdasarkan nomor antrian.
  ///
  /// Contoh implementasi API nanti:
  /// ```dart
  /// Future<Transaksi?> getByNoAntrian(String noAntrian) async {
  ///   final res = await api.get('/transaksi/antrian/$noAntrian');
  ///   if (res.data == null) return null;
  ///   return Transaksi.fromJson(res.data);
  /// }
  /// ```
  Future<Transaksi?> getByNoAntrian(String noAntrian) async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (noAntrian.trim().isEmpty) return null;
    // Dummy: kembalikan data apapun nomor yang diinput
    return getDummyTransaksi();
  }

  /// Proses pembayaran transaksi.
  ///
  /// Contoh implementasi API nanti:
  /// ```dart
  /// Future<bool> bayar(String idTransaksi, String metodePembayaran) async {
  ///   final res = await api.post('/transaksi/$idTransaksi/bayar', {
  ///     'metode': metodePembayaran,
  ///   });
  ///   return res.statusCode == 200;
  /// }
  /// ```
  Future<bool> bayar(String idTransaksi, String metodePembayaran) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return true; // dummy: selalu berhasil
  }
}
