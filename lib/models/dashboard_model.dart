// Lokasi: lib/models/dashboard_model.dart

class DashboardStatistik {
  final double totalPendapatan;
  final int jumlahTransaksi;
  final int jumlahPasien;

  DashboardStatistik({
    required this.totalPendapatan,
    required this.jumlahTransaksi,
    required this.jumlahPasien,
  });

  factory DashboardStatistik.fromJson(Map<String, dynamic> json) {
    return DashboardStatistik(
      totalPendapatan: (json['total_pendapatan'] as num).toDouble(),
      jumlahTransaksi: json['jumlah_transaksi'] as int,
      jumlahPasien: json['jumlah_pasien'] as int,
    );
  }
}

class PendapatanHarian {
  final DateTime tanggal;
  final double pendapatan;

  PendapatanHarian({required this.tanggal, required this.pendapatan});

  factory PendapatanHarian.fromJson(Map<String, dynamic> json) {
    return PendapatanHarian(
      tanggal: DateTime.parse(json['tanggal'] as String),
      pendapatan: (json['pendapatan'] as num).toDouble(),
    );
  }
}

class LayananStatistik {
  final String namaLayanan;
  final int digunakan;
  final double pendapatan;

  LayananStatistik({
    required this.namaLayanan,
    required this.digunakan,
    required this.pendapatan,
  });

  factory LayananStatistik.fromJson(Map<String, dynamic> json) {
    return LayananStatistik(
      namaLayanan: json['nama_layanan'] as String,
      digunakan: json['digunakan'] as int,
      pendapatan: (json['pendapatan'] as num).toDouble(),
    );
  }
}

// ============================================================
// DUMMY DATA — Ganti dengan pemanggilan API saat siap.
// ============================================================

DashboardStatistik getDummyDashboardStatistik() {
  return DashboardStatistik(
    totalPendapatan: 17890000,
    jumlahTransaksi: 42,
    jumlahPasien: 35,
  );
}

List<PendapatanHarian> getDummyPendapatanMingguan() {
  final now = DateTime(2026, 5, 24);
  return [
    PendapatanHarian(
      tanggal: now.subtract(const Duration(days: 6)),
      pendapatan: 2400000,
    ),
    PendapatanHarian(
      tanggal: now.subtract(const Duration(days: 5)),
      pendapatan: 1850000,
    ),
    PendapatanHarian(
      tanggal: now.subtract(const Duration(days: 4)),
      pendapatan: 2050000,
    ),
    PendapatanHarian(
      tanggal: now.subtract(const Duration(days: 3)),
      pendapatan: 1950000,
    ),
    PendapatanHarian(
      tanggal: now.subtract(const Duration(days: 2)),
      pendapatan: 2250000,
    ),
    PendapatanHarian(
      tanggal: now.subtract(const Duration(days: 1)),
      pendapatan: 2600000,
    ),
    PendapatanHarian(tanggal: now, pendapatan: 2120000),
  ];
}

List<LayananStatistik> getDummyStatistikLayanan() {
  return [
    LayananStatistik(
      namaLayanan: 'Registrasi',
      digunakan: 18,
      pendapatan: 1800000,
    ),
    LayananStatistik(
      namaLayanan: 'Farmasi',
      digunakan: 12,
      pendapatan: 2400000,
    ),
    LayananStatistik(
      namaLayanan: 'Laboratorium',
      digunakan: 8,
      pendapatan: 1600000,
    ),
    LayananStatistik(
      namaLayanan: 'Radiologi',
      digunakan: 5,
      pendapatan: 1000000,
    ),
  ];
}
