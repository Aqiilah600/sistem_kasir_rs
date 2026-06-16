// Lokasi: lib/models/obat_model.dart

class Obat {
  final int idObat;
  final String nama;
  final String jenis;
  final int stok;
  final double harga;
  final String exp; // format: dd/MM/yyyy

  Obat({
    required this.idObat,
    required this.nama,
    required this.jenis,
    required this.stok,
    required this.harga,
    required this.exp,
  });

  factory Obat.fromJson(Map<String, dynamic> json) {
    return Obat(
      idObat: json['id_obat'] as int,
      nama: json['nama'] as String,
      jenis: json['jenis'] as String,
      stok: (json['stok'] as num).toInt(),
      harga: (json['harga'] as num).toDouble(),
      exp: json['exp'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id_obat': idObat,
    'nama': nama,
    'jenis': jenis,
    'stok': stok,
    'harga': harga,
    'exp': exp,
  };
}

// ============================================================
// DUMMY DATA — Ganti dengan ObatService.getAllObat() saat API
// tersedia.
// ============================================================
final List<Obat> dummyObat = [
  Obat(
    idObat: 1,
    nama: 'Cefadroxil 500mg',
    jenis: 'Antibiotik',
    stok: 80,
    harga: 15000,
    exp: '08/05/2027',
  ),
  Obat(
    idObat: 2,
    nama: 'Myanta Cair 60ml',
    jenis: 'Antasida',
    stok: 45,
    harga: 18000,
    exp: '07/07/2027',
  ),
  Obat(
    idObat: 3,
    nama: 'Bodrex Migra',
    jenis: 'Analgesik',
    stok: 65,
    harga: 8500,
    exp: '07/06/2027',
  ),
];
