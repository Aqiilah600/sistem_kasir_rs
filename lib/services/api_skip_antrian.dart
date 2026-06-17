// lib/services/api_skip_antrian.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiSkipAntrian {
  static const String baseUrl = 'http://kasir4b06.vps-poliban.my.id/api';

  // Skip antrian
  static Future<Map<String, dynamic>> skipAntrian(int id) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/antrian-pembayaran/$id/skip'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {'success': true, 'data': data};
      } else {
        return {
          'success': false,
          'message': 'Gagal skip antrian: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Get daftar antrian (semua)
  static Future<Map<String, dynamic>> getDaftarAntrian() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/antrian-pembayaran'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {'success': true, 'data': data};
      } else {
        return {
          'success': false,
          'message': 'Gagal mengambil daftar antrian: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Get daftar antrian yang di-skip
  static Future<Map<String, dynamic>> getSkippedAntrian() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/antrian-pembayaran/skip'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {'success': true, 'data': data};
      } else {
        return {
          'success': false,
          'message': 'Gagal mengambil daftar skip: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }
}
