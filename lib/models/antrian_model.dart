class AntriItem {
  final int id;
  final int nomor;
  final String nama;
  final String poli;
  String status;
  final String waktuMasuk;
  final String idTransaksi;
  final int idAntrian;

  AntriItem({
    required this.id,
    required this.nomor,
    required this.nama,
    required this.poli,
    required this.status,
    required this.waktuMasuk,
    required this.idTransaksi,
    required this.idAntrian,
  });

  factory AntriItem.fromJson(Map<String, dynamic> json) {
    final nestedPasien = json['pasien'] is Map<String, dynamic>
        ? json['pasien'] as Map<String, dynamic>
        : const <String, dynamic>{};
    final nestedPoli = json['poli'] is Map<String, dynamic>
        ? json['poli'] as Map<String, dynamic>
        : const <String, dynamic>{};

    return AntriItem(
      id: _toInt(json['id_antrian_pay'] ?? json['id'] ?? json['id_antrian']),
      nomor: _toInt(json['no_pembayaran'] ?? json['nomor'] ?? json['nomor_antrian'] ?? json['no_antrian'] ?? json['antrian']),
      nama: _toText(json['nama_pasien'] ?? json['nama'] ?? nestedPasien['nama'], fallback: '-'),
      poli: _toText(json['nama_poli'] ?? json['poli'] ?? nestedPoli['nama'], fallback: '-'),
      status: _normalizeStatus(json['status_antrian'] ?? json['status']),
      waktuMasuk: _toText(json['waktu_masuk']),
      idTransaksi: _toText(json['id_transaksi']),
      idAntrian: _toInt(json['id_antrian']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id_antrian_pay': id,
    'no_pembayaran': nomor,
    'nama_pasien': nama,
    'poli': poli,
    'status_antrian': status,
    'waktu_masuk': waktuMasuk,
    'id_transaksi': idTransaksi,
    'id_antrian': idAntrian,
  };

  AntriItem copyWith({String? status}) {
    return AntriItem(
      id: id,
      nomor: nomor,
      nama: nama,
      poli: poli,
      status: status ?? this.status,
      waktuMasuk: waktuMasuk,
      idTransaksi: idTransaksi,
      idAntrian: idAntrian,
    );
  }
}

List<AntriItem> getInitialAntrian() {
  return [
    AntriItem(id: 1, nomor: 3, nama: 'Aulia', poli: 'Poli Gigi', status: 'Menunggu', waktuMasuk: '08:05', idTransaksi: '1002', idAntrian: 3),
    AntriItem(id: 2, nomor: 4, nama: 'Nazwarni Aulia', poli: 'Poli Jantung', status: 'Menunggu', waktuMasuk: '08:12', idTransaksi: '1003', idAntrian: 4),
    AntriItem(id: 3, nomor: 5, nama: 'Muzakir', poli: 'Poli Jantung', status: 'Menunggu', waktuMasuk: '08:15', idTransaksi: '1004', idAntrian: 5),
    AntriItem(id: 4, nomor: 6, nama: 'Iki Jawir', poli: 'Poli Mata', status: 'Menunggu', waktuMasuk: '08:18', idTransaksi: '1005', idAntrian: 6),
  ];
}

class AntriStatistik {
  final int totalAntrian;
  final int menunggu;
  final int sedangDilayani;
  final int selesai;
  final int dilewati;

  AntriStatistik({
    required this.totalAntrian,
    required this.menunggu,
    required this.sedangDilayani,
    required this.selesai,
    required this.dilewati,
  });

  factory AntriStatistik.fromJson(Map<String, dynamic> json) {
    return AntriStatistik(
      totalAntrian: _toInt(json['total_antrian'] ?? json['total']),
      menunggu: _toInt(json['menunggu']),
      sedangDilayani: _toInt(json['sedang_dilayani'] ?? json['dilayani']),
      selesai: _toInt(json['selesai']),
      dilewati: _toInt(json['tidak_hadir'] ?? json['skip'] ?? json['dilewati']),
    );
  }

  factory AntriStatistik.fromList(List<AntriItem> items) {
    return AntriStatistik(
      totalAntrian: items.length,
      menunggu: items.where((e) => e.status == 'Menunggu').length,
      sedangDilayani: items.where((e) => e.status == 'Sedang Dilayani').length,
      selesai: items.where((e) => e.status == 'Selesai').length,
      dilewati: items.where((e) => e.status == 'Dilewati').length,
    );
  }
}

int _toInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

String _toText(dynamic value, {String fallback = ''}) {
  final text = value?.toString();
  if (text == null || text == 'null' || text.isEmpty) return fallback;
  return text;
}

String _normalizeStatus(dynamic value) {
  final raw = _toText(value, fallback: 'Menunggu').toLowerCase().replaceAll('_', ' ');
  if (raw.contains('sedang') || raw.contains('dilayani') || raw == 'dipanggil') return 'Sedang Dilayani';
  if (raw.contains('selesai')) return 'Selesai';
  if (raw.contains('skip') || raw.contains('tidak hadir') || raw.contains('dilewati')) return 'Dilewati';
  return 'Menunggu';
}
