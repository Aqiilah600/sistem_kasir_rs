import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiException implements Exception {
  final int statusCode;
  final String message;
  final dynamic data;

  ApiException(this.statusCode, this.message, {this.data});

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiClient {
  static const String baseUrl = 'http://kasir4b06.vps-poliban.my.id/api';

  const ApiClient();

  Map<String, String> get _headers => const {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) {
    return _send('GET', path, query: query);
  }

  Future<dynamic> post(String path, {Map<String, dynamic>? body}) {
    return _send('POST', path, body: body);
  }

  Future<dynamic> put(String path, {Map<String, dynamic>? body}) {
    return _send('PUT', path, body: body);
  }

  Future<dynamic> delete(String path) {
    return _send('DELETE', path);
  }

  Future<dynamic> _send(
    String method,
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  }) async {
    final uri = Uri.parse('$baseUrl$path').replace(
      queryParameters: query?.map(
        (key, value) => MapEntry(key, value?.toString() ?? ''),
      ),
    );

    final encodedBody = body == null ? null : jsonEncode(body);
    final response = switch (method) {
      'GET' => await http.get(uri, headers: _headers),
      'POST' => await http.post(uri, headers: _headers, body: encodedBody),
      'PUT' => await http.put(uri, headers: _headers, body: encodedBody),
      'DELETE' => await http.delete(uri, headers: _headers),
      _ => throw UnsupportedError('HTTP method tidak didukung: $method'),
    };

    final decoded = _decode(response.body);
    final ok = response.statusCode >= 200 && response.statusCode < 300;

    if (!ok) {
      throw ApiException(
        response.statusCode,
        _message(decoded) ?? 'Request gagal (${response.statusCode})',
        data: decoded,
      );
    }

    if (decoded is Map<String, dynamic> && decoded['success'] == false) {
      throw ApiException(
        response.statusCode,
        _message(decoded) ?? 'Request gagal',
        data: decoded,
      );
    }

    return decoded;
  }

  dynamic _decode(String body) {
    if (body.trim().isEmpty) return null;
    return jsonDecode(body);
  }

  String? _message(dynamic decoded) {
    if (decoded is Map<String, dynamic>) {
      return decoded['message']?.toString();
    }
    return null;
  }

  static dynamic unwrapData(dynamic response) {
    if (response is Map<String, dynamic> && response.containsKey('data')) {
      return response['data'];
    }
    return response;
  }
}
