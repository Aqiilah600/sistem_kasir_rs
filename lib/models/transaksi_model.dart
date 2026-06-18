import 'obat_model.dart';

class Transaction {
  final String id;
  final String keterangan;
  final double jumlah;
  final DateTime tanggal;
  final String kategori;

  Transaction({required this.id, required this.keterangan, required this.jumlah, required this.tanggal, required this.kategori});
}

List<Transaction> getDummyTransactions() => [
  Transaction(id: '1', keterangan: 'Total Transaksi', jumlah: 80000, tanggal: DateTime(2026, 1, 5), kategori: 'transaksi'),
  Transaction(id: '2', keterangan: 'Pendapatan Obat', jumlah: 90000, tanggal: DateTime(2026, 1, 10), kategori: 'obat'),
  Transaction(id: '3', keterangan: 'Pendapatan Layanan', jumlah: 120000, tanggal: DateTime(2026, 1, 15), kategori: 'layanan'),
];

String formatCurrency(double value) => 'Rp ${(value).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match.group(1)}.')}';
String formatDate(DateTime date) => '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

class ItemObat {
  final String nama;
  final int jumlah;
  final double harga;

  ItemObat({required this.nama, required this.jumlah, required this.harga});
  double get subtotal => jumlah * harga;

  factory ItemObat.fromJson(Map<String, dynamic> json) => ItemObat(
    nama: _text(json['nama'] ?? json['nama_obat'], fallback: '-'),
    jumlah: _int(json['jumlah']),
    harga: _double(json['harga'] ?? json['harga_jual'] ?? json['total_harga']),
  );

  Map<String, dynamic> toJson() => {'nama': nama, 'jumlah': jumlah, 'harga': harga};
}

class ItemLayanan {
  final String nama;
  final int jumlah;
  final double harga;

  ItemLayanan({required this.nama, required this.jumlah, required this.harga});
  double get subtotal => jumlah * harga;

  factory ItemLayanan.fromJson(Map<String, dynamic> json) => ItemLayanan(
    nama: _text(json['nama'] ?? json['nama_layanan'] ?? json['nama_poli'], fallback: 'Layanan Medis'),
    jumlah: _int(json['jumlah'] ?? 1),
    harga: _double(json['harga'] ?? json['tarif'] ?? json['subtotal']),
  );

  Map<String, dynamic> toJson() => {'nama': nama, 'jumlah': jumlah, 'harga': harga};
}

class Transaksi {
  final String idTransaksi;
  final String idRm;
  final String namaPasien;
  final double tarifDokter;
  final double tarifPerawat;
  final double subtotalObat;
  final String status;
  final String tanggal;
  final String noInvoice;
  final List<ItemObat> daftarObat;
  final List<ItemLayanan> daftarLayanan;

  Transaksi({
    required this.idTransaksi,
    required this.idRm,
    required this.namaPasien,
    required this.tarifDokter,
    required this.tarifPerawat,
    required this.subtotalObat,
    required this.status,
    required this.tanggal,
    required this.noInvoice,
    required this.daftarObat,
    required this.daftarLayanan,
  });

  double get totalObat => daftarObat.isEmpty ? subtotalObat : daftarObat.fold(0, (sum, item) => sum + item.subtotal);
  double get totalLayanan => daftarLayanan.fold(0, (sum, item) => sum + item.subtotal);
  double get totalKeseluruhan => tarifDokter + tarifPerawat + totalObat + totalLayanan;

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    final tx = json['transaksi'] is Map<String, dynamic> ? json['transaksi'] as Map<String, dynamic> : json;
    final ringkasan = json['ringkasan'] is Map<String, dynamic> ? json['ringkasan'] as Map<String, dynamic> : const <String, dynamic>{};
    final obatRaw = json['detail_obat'] ?? json['daftar_obat'] ?? tx['detail_obat'] ?? const [];
    final layananRaw = json['daftar_layanan'] ?? json['detail_layanan'] ?? const [];
    final obat = obatRaw is List ? obatRaw.whereType<Map<String, dynamic>>().map(ItemObat.fromJson).toList() : <ItemObat>[];
    final layanan = layananRaw is List ? layananRaw.whereType<Map<String, dynamic>>().map(ItemLayanan.fromJson).toList() : <ItemLayanan>[];
    final dokter = _double(ringkasan['biaya_dokter'] ?? tx['tarif_dokter']);
    final perawat = _double(ringkasan['biaya_perawat'] ?? tx['tarif_perawat']);
    final subtotalObat = _double(ringkasan['subtotal_obat'] ?? tx['subtotal_obat']);

    return Transaksi(
      idTransaksi: _text(tx['id_transaksi']),
      idRm: _text(tx['id_rm']),
      namaPasien: _text(tx['nama_pasien'], fallback: '-'),
      tarifDokter: dokter,
      tarifPerawat: perawat,
      subtotalObat: subtotalObat,
      status: _text(tx['status'], fallback: 'Menunggu'),
      tanggal: _text(tx['tanggal']),
      noInvoice: _text(tx['no_invoice'], fallback: 'INV-${_text(tx['id_transaksi'])}'),
      daftarObat: obat,
      daftarLayanan: layanan.isNotEmpty ? layanan : [ItemLayanan(nama: _text(tx['nama_poli'], fallback: 'Layanan Medis'), jumlah: 1, harga: dokter + perawat)],
    );
  }

  Map<String, dynamic> toJson() => {
    'id_transaksi': idTransaksi,
    'id_rm': idRm,
    'nama_pasien': namaPasien,
    'tarif_dokter': tarifDokter,
    'tarif_perawat': tarifPerawat,
    'subtotal_obat': subtotalObat,
    'status': status,
    'tanggal': tanggal,
    'no_invoice': noInvoice,
    'daftar_obat': daftarObat.map((e) => e.toJson()).toList(),
    'daftar_layanan': daftarLayanan.map((e) => e.toJson()).toList(),
  };
}

Transaksi getDummyTransaksi() => Transaksi(
  idTransaksi: '1002', idRm: '9920', namaPasien: 'Aulia', tarifDokter: 120000, tarifPerawat: 50000, subtotalObat: 15000, status: 'Menunggu', tanggal: '2026-04-23', noInvoice: 'INV-2026/001-000',
  daftarObat: [ItemObat(nama: dummyObat[0].nama, jumlah: 1, harga: dummyObat[0].harga)],
  daftarLayanan: [ItemLayanan(nama: 'Poli Gigi', jumlah: 1, harga: 120000)],
);

List<Transaksi> getDummyTransaksiList() => [getDummyTransaksi()];

int _int(dynamic value) => value is int ? value : value is num ? value.toInt() : int.tryParse(value?.toString() ?? '') ?? 0;
double _double(dynamic value) => value is num ? value.toDouble() : double.tryParse((value?.toString() ?? '').replaceAll('.', '').replaceAll(',', '.')) ?? 0;
String _text(dynamic value, {String fallback = ''}) {
  final text = value?.toString();
  if (text == null || text.isEmpty || text == 'null') return fallback;
  return text;
}
