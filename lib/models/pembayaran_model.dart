class Pembayaran {
  final int idPembayaran;
  final String idTransaksi;
  final String metode;
  final double totalTagihan;
  final double jumlahPembayaran;
  final double kembalian;
  final String statusPembayaran;
  final String tanggalPembayaran;

  Pembayaran({required this.idPembayaran, required this.idTransaksi, required this.metode, required this.totalTagihan, required this.jumlahPembayaran, required this.kembalian, required this.statusPembayaran, required this.tanggalPembayaran});

  factory Pembayaran.fromJson(Map<String, dynamic> json) {
    final pembayaran = json['pembayaran'] is Map<String, dynamic> ? json['pembayaran'] as Map<String, dynamic> : json;
    return Pembayaran(
      idPembayaran: _int(pembayaran['id_pembayaran']),
      idTransaksi: _text(pembayaran['id_transaksi']),
      metode: _text(pembayaran['metode']),
      totalTagihan: _double(pembayaran['total_tagihan']),
      jumlahPembayaran: _double(pembayaran['jumlah_pembayaran']),
      kembalian: _double(pembayaran['kembalian']),
      statusPembayaran: _text(pembayaran['status_pembayaran'], fallback: 'pending'),
      tanggalPembayaran: _text(pembayaran['tanggal_pembayaran'] ?? pembayaran['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id_pembayaran': idPembayaran,
    'id_transaksi': idTransaksi,
    'metode': metode,
    'total_tagihan': totalTagihan,
    'jumlah_pembayaran': jumlahPembayaran,
    'kembalian': kembalian,
    'status_pembayaran': statusPembayaran,
    'tanggal_pembayaran': tanggalPembayaran,
  };
}

class PembayaranRequest {
  final String idTransaksi;
  final String metode;
  final double totalTagihan;
  final double jumlahPembayaran;

  PembayaranRequest({required this.idTransaksi, required this.metode, required this.totalTagihan, required this.jumlahPembayaran});

  Map<String, dynamic> toJson() => {
    'id_transaksi': idTransaksi,
    'metode': metode,
    'total_tagihan': totalTagihan,
    'jumlah_pembayaran': jumlahPembayaran,
  };
}

int _int(dynamic value) => value is int ? value : value is num ? value.toInt() : int.tryParse(value?.toString() ?? '') ?? 0;
double _double(dynamic value) => value is num ? value.toDouble() : double.tryParse((value?.toString() ?? '').replaceAll('.', '').replaceAll(',', '.')) ?? 0;
String _text(dynamic value, {String fallback = ''}) {
  final text = value?.toString();
  if (text == null || text.isEmpty || text == 'null') return fallback;
  return text;
}
