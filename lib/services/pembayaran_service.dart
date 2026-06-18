import '../models/pembayaran_model.dart';
import 'api_client.dart';

class PembayaranService {
  static const ApiClient _client = ApiClient();

  Future<List<Pembayaran>> getAll() async {
    final response = await _client.get('/pembayaran');
    final data = ApiClient.unwrapData(response);
    if (data is! List) return [];
    return data.whereType<Map<String, dynamic>>().map(Pembayaran.fromJson).toList();
  }

  Future<dynamic> create(PembayaranRequest request) async {
    final response = await _client.post('/pembayaran', body: request.toJson());
    return ApiClient.unwrapData(response);
  }

  Future<dynamic> detail(int idPembayaran) async {
    final response = await _client.get('/pembayaran/$idPembayaran');
    return ApiClient.unwrapData(response);
  }

  Future<dynamic> update(int idPembayaran, {String? metode, double? jumlahPembayaran, String? statusPembayaran}) async {
    final body = <String, dynamic>{
      'metode': ?metode,
      'jumlah_pembayaran': ?jumlahPembayaran,
      'status_pembayaran': ?statusPembayaran,
    };
    final response = await _client.put('/pembayaran/$idPembayaran', body: body);
    return ApiClient.unwrapData(response);
  }

  Future<void> delete(int idPembayaran) async {
    await _client.delete('/pembayaran/$idPembayaran');
  }

  Future<dynamic> statistik({int? bulan, int? tahun}) async {
    final response = await _client.get('/pembayaran/statistik', query: {
      'bulan': ?bulan,
      'tahun': ?tahun,
    });
    return ApiClient.unwrapData(response);
  }

  Future<dynamic> laporan({String? tanggalMulai, String? tanggalAkhir}) async {
    final response = await _client.get('/pembayaran/laporan', query: {
      'tanggal_mulai': ?tanggalMulai,
      'tanggal_akhir': ?tanggalAkhir,
    });
    return ApiClient.unwrapData(response);
  }

  Future<dynamic> grafik() async => ApiClient.unwrapData(await _client.get('/pembayaran/grafik'));
  Future<dynamic> statistikLayanan() async => ApiClient.unwrapData(await _client.get('/pembayaran/statistik-layanan'));
}
