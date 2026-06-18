import '../models/pembayaran_model.dart';
import '../models/transaksi_model.dart';
import 'api_client.dart';
import 'pembayaran_service.dart';

class TransaksiService {
  static const ApiClient _client = ApiClient();
  final PembayaranService _pembayaranService = PembayaranService();

  Future<List<Transaksi>> getAll() async {
    final response = await _client.get('/transaksi');
    final data = ApiClient.unwrapData(response);
    if (data is! List) return [];
    return data.whereType<Map<String, dynamic>>().map(Transaksi.fromJson).toList();
  }

  Future<dynamic> create({
    required int pasienId,
    required int idAntrian,
    required int idRm,
    required int idDokter,
    required int idPerawat,
    int? idResep,
  }) async {
    final response = await _client.post('/transaksi', body: {
      'pasien_id': pasienId,
      'id_antrian': idAntrian,
      'id_rm': idRm,
      'id_dokter': idDokter,
      'id_perawat': idPerawat,
      'id_resep': idResep,
    });
    return ApiClient.unwrapData(response);
  }

  Future<Transaksi?> detail(String idTransaksi) async {
    final response = await _client.get('/transaksi/$idTransaksi');
    final data = ApiClient.unwrapData(response);
    if (data is Map<String, dynamic>) return Transaksi.fromJson(data);
    return null;
  }

  Future<dynamic> update(String idTransaksi, {int? idResep}) async {
    final response = await _client.put('/transaksi/$idTransaksi', body: {
      'id_resep': ?idResep,
    });
    return ApiClient.unwrapData(response);
  }

  Future<void> delete(String idTransaksi) async {
    await _client.delete('/transaksi/$idTransaksi');
  }

  Future<Transaksi?> getByNoAntrian(String noAntrian) async {
    if (noAntrian.trim().isEmpty) return null;
    final response = await _client.get('/transaksi/antrian/nomor/$noAntrian');
    final data = ApiClient.unwrapData(response);
    if (data is Map<String, dynamic>) return Transaksi.fromJson(data);
    return null;
  }

  Future<Transaksi?> getByIdAntrian(String idAntrian) async {
    final response = await _client.get('/transaksi/$idAntrian/antrian');
    final data = ApiClient.unwrapData(response);
    if (data is Map<String, dynamic>) return Transaksi.fromJson(data);
    return null;
  }

  Future<dynamic> jumlahPasien() async {
    final response = await _client.get('/transaksi/jumlah-pasien');
    return ApiClient.unwrapData(response);
  }

  Future<bool> bayar(String idTransaksi, String metodePembayaran, {double? totalTagihan, double? jumlahPembayaran}) async {
    final total = totalTagihan ?? 0;
    final jumlah = jumlahPembayaran ?? total;
    await _pembayaranService.create(PembayaranRequest(
      idTransaksi: idTransaksi,
      metode: _normalizeMetode(metodePembayaran),
      totalTagihan: total,
      jumlahPembayaran: jumlah,
    ));
    return true;
  }

  String _normalizeMetode(String value) {
    final lower = value.toLowerCase();
    if (lower.contains('qris')) return 'qris';
    if (lower.contains('debit') || lower.contains('kartu')) return 'debit';
    return 'cash';
  }
}
