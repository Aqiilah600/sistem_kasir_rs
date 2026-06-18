import '../services/pembayaran_service.dart' as pembayaran_api;
import '../services/transaksi_services.dart' as transaksi_api;

class RTransaksi {
  final String invoice;
  final String tanggal;
  final String pasien;
  final String poli;
  final String metode;

  RTransaksi({required this.invoice, required this.tanggal, required this.pasien, required this.poli, required this.metode});

  factory RTransaksi.fromMap(Map<String, dynamic> data) {
    return RTransaksi(
      invoice: _text(data['invoice'] ?? data['no_invoice'] ?? data['id_pembayaran'] ?? data['id_transaksi']),
      tanggal: _text(data['tanggal'] ?? data['tanggal_pembayaran'] ?? data['created_at']),
      pasien: _text(data['pasien'] ?? data['nama_pasien'], fallback: '-'),
      poli: _text(data['poli'] ?? data['nama_poli'], fallback: '-'),
      metode: _text(data['metode'], fallback: '-'),
    );
  }

  Map<String, dynamic> toMap() => {'invoice': invoice, 'tanggal': tanggal, 'pasien': pasien, 'poli': poli, 'metode': metode};
}

class TransaksiService {
  final pembayaran_api.PembayaranService _pembayaranService = pembayaran_api.PembayaranService();
  final transaksi_api.TransaksiService _transaksiService = transaksi_api.TransaksiService();

  Future<List<RTransaksi>> getAllTransaksi() async {
    try {
      final pembayaran = await _pembayaranService.getAll();
      if (pembayaran.isNotEmpty) {
        return pembayaran.map((e) => RTransaksi.fromMap(e.toJson())).toList();
      }
    } catch (_) {}

    try {
      final transaksi = await _transaksiService.getAll();
      return transaksi.map((e) => RTransaksi.fromMap(e.toJson())).toList();
    } catch (_) {
      return [];
    }
  }

  Future<List<RTransaksi>> searchTransaksi(String query) async {
    final items = await getAllTransaksi();
    if (query.isEmpty) return items;
    final lower = query.toLowerCase();
    return items.where((item) => item.pasien.toLowerCase().contains(lower) || item.invoice.toLowerCase().contains(lower)).toList();
  }
}

String _text(dynamic value, {String fallback = ''}) {
  final text = value?.toString();
  if (text == null || text.isEmpty || text == 'null') return fallback;
  return text;
}
