// Lokasi: lib/models/transaksi_model.dart
import 'obat_model.dart';

class ItemObat {
  final String nama;
  final int jumlah;
  final double harga;

  ItemObat({required this.nama, required this.jumlah, required this.harga});

  double get subtotal => jumlah * harga;

  factory ItemObat.fromJson(Map<String, dynamic> json) => ItemObat(
    nama: json['nama'] as String,
    jumlah: (json['jumlah'] as num).toInt(),
    harga: (json['harga'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'nama': nama,
    'jumlah': jumlah,
    'harga': harga,
  };
}

class ItemLayanan {
  final String nama;
  final int jumlah;
  final double harga;

  ItemLayanan({required this.nama, required this.jumlah, required this.harga});

  double get subtotal => jumlah * harga;

  factory ItemLayanan.fromJson(Map<String, dynamic> json) => ItemLayanan(
    nama: json['nama'] as String,
    jumlah: (json['jumlah'] as num).toInt(),
    harga: (json['harga'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'nama': nama,
    'jumlah': jumlah,
    'harga': harga,
  };
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

  double get totalObat =>
      daftarObat.fold(0, (sum, item) => sum + item.subtotal);

  double get totalLayanan =>
      daftarLayanan.fold(0, (sum, item) => sum + item.subtotal);

  double get totalKeseluruhan =>
      tarifDokter + tarifPerawat + totalObat + totalLayanan;

  factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
    idTransaksi: json['id_transaksi'].toString(),
    idRm: json['id_rm'].toString(),
    namaPasien: json['nama_pasien'] as String,
    tarifDokter: (json['tarif_dokter'] as num).toDouble(),
    tarifPerawat: (json['tarif_perawat'] as num).toDouble(),
    subtotalObat: (json['subtotal_obat'] as num).toDouble(),
    status: json['status'] as String,
    tanggal: json['tanggal'] as String,
    noInvoice: json['no_invoice'] as String,
    daftarObat: (json['daftar_obat'] as List)
        .map((e) => ItemObat.fromJson(e))
        .toList(),
    daftarLayanan: (json['daftar_layanan'] as List)
        .map((e) => ItemLayanan.fromJson(e))
        .toList(),
  );

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

// ============================================================
// DUMMY DATA — Ganti dengan TransaksiService.getByNoAntrian()
// saat API tersedia.
// ============================================================
// Dummy transaksi yang disesuaikan dengan data antrian
Transaksi getDummyTransaksi() => Transaksi(
  idTransaksi: '1002', // sesuai dengan AntriItem idTransaksi di antrian_model
  idRm: '9920',
  namaPasien: 'Aulia',
  tarifDokter: 120000,
  tarifPerawat: 50000,
  subtotalObat: 15000,
  status: 'Menunggu',
  tanggal: '2026-04-23',
  noInvoice: 'INV-2026/001-000',
  daftarObat: [
    // Ambil data dari dummyObat di obat_model.dart
    ItemObat(nama: dummyObat[0].nama, jumlah: 1, harga: dummyObat[0].harga),
  ],
  daftarLayanan: [ItemLayanan(nama: 'Poli Gigi', jumlah: 1, harga: 120000)],
);

// Tambahan: beberapa data dummy lain untuk keperluan testing
List<Transaksi> getDummyTransaksiList() => [
  // Sesuaikan dengan getInitialAntrian() di antrian_model.dart
  getDummyTransaksi(),
  Transaksi(
    idTransaksi: '1003',
    idRm: '9921',
    namaPasien: 'Nazwarni Aulia',
    tarifDokter: 180000,
    tarifPerawat: 80000,
    subtotalObat: 8000,
    status: 'Menunggu',
    tanggal: '2026-04-23',
    noInvoice: 'INV-2026/001-001',
    daftarObat: [
      ItemObat(nama: dummyObat[0].nama, jumlah: 2, harga: dummyObat[0].harga),
      ItemObat(nama: dummyObat[1].nama, jumlah: 3, harga: dummyObat[1].harga),
    ],
    daftarLayanan: [
      ItemLayanan(nama: 'Poli Jantung', jumlah: 1, harga: 180000),
    ],
  ),
  Transaksi(
    idTransaksi: '1004',
    idRm: '9922',
    namaPasien: 'Muzakir',
    tarifDokter: 150000,
    tarifPerawat: 60000,
    subtotalObat: 25000,
    status: 'Selesai',
    tanggal: '2026-04-20',
    noInvoice: 'INV-2026/001-002',
    daftarObat: [
      ItemObat(nama: dummyObat[2].nama, jumlah: 5, harga: dummyObat[2].harga),
    ],
    daftarLayanan: [
      ItemLayanan(nama: 'Poli Jantung', jumlah: 1, harga: 150000),
    ],
  ),
  Transaksi(
    idTransaksi: '1005',
    idRm: '9923',
    namaPasien: 'Iki Jawir',
    tarifDokter: 200000,
    tarifPerawat: 90000,
    subtotalObat: 0,
    status: 'Dalam Proses',
    tanggal: '2026-04-22',
    noInvoice: 'INV-2026/001-003',
    daftarObat: [],
    daftarLayanan: [ItemLayanan(nama: 'Poli Mata', jumlah: 1, harga: 200000)],
  ),
];
