import '../models/antrian_model.dart';
import 'api_client.dart';

class ApiSkipAntrian {
  static const String baseUrl = ApiClient.baseUrl;
  static const ApiClient _client = ApiClient();

  static Future<Map<String, dynamic>> getAntrianPembayaran() => getDaftarAntrian();

  static Future<Map<String, dynamic>> getDaftarAntrian() async {
    return _wrap(() async {
      final response = await _client.get('/antrian-pembayaran');
      return ApiClient.unwrapData(response);
    });
  }

  static Future<Map<String, dynamic>> getSedangDilayani() async {
    return _wrap(() async {
      final response = await _client.get('/antrian-pembayaran/sedang-dilayani');
      return ApiClient.unwrapData(response);
    });
  }

  static Future<Map<String, dynamic>> getSkippedAntrian() async {
    return _wrap(() async {
      final response = await _client.get('/antrian-pembayaran/skip');
      return ApiClient.unwrapData(response);
    });
  }

  static Future<Map<String, dynamic>> getDetailAntrian(int id) async {
    return _wrap(() async {
      final response = await _client.get('/antrian-pembayaran/$id');
      return ApiClient.unwrapData(response);
    });
  }

  static Future<Map<String, dynamic>> panggilUlangAntrian(int id) => panggilAntrian(id);

  static Future<Map<String, dynamic>> panggilAntrian(int id) async {
    return _wrap(() async {
      final response = await _client.put('/antrian-pembayaran/$id/panggil');
      return ApiClient.unwrapData(response);
    });
  }

  static Future<Map<String, dynamic>> skipAntrian(int id) async {
    return _wrap(() async {
      final response = await _client.put('/antrian-pembayaran/$id/skip');
      return ApiClient.unwrapData(response);
    });
  }

  static Future<Map<String, dynamic>> getStatistik() async {
    return _wrap(() async {
      final response = await _client.get('/antrian-pembayaran/statistik');
      final data = ApiClient.unwrapData(response);
      if (data is Map<String, dynamic>) return AntriStatistik.fromJson(data);
      return data;
    });
  }

  static Future<Map<String, dynamic>> _wrap(Future<dynamic> Function() action) async {
    try {
      final data = await action();
      return {'success': true, 'data': data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
