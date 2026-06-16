class AntriItem {
  final int id;
  final int nomor;
  final String nama;
  final String poli;
  String status; // "Menunggu", "Sedang Dilayani", "Selesai", "Dilewati"
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

  // Copy with untuk membuat instance baru dengan status berubah
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

// Dummy data - AWALNYA SEMUA "Menunggu"
List<AntriItem> getInitialAntrian() {
  return [
    AntriItem(
      id: 1,
      nomor: 3,
      nama: 'Aulia',
      poli: 'Poli Gigi',
      status: 'Menunggu',
      waktuMasuk: '08:05',
      idTransaksi: '1002',
      idAntrian: 3,
    ),
    AntriItem(
      id: 2,
      nomor: 4,
      nama: 'Nazwarni Aulia',
      poli: 'Poli Jantung',
      status: 'Menunggu',
      waktuMasuk: '08:12',
      idTransaksi: '1003',
      idAntrian: 4,
    ),
    AntriItem(
      id: 3,
      nomor: 5,
      nama: 'Muzakir',
      poli: 'Poli Jantung',
      status: 'Menunggu',
      waktuMasuk: '08:15',
      idTransaksi: '1004',
      idAntrian: 5,
    ),
    AntriItem(
      id: 4,
      nomor: 6,
      nama: 'Iki Jawir',
      poli: 'Poli Mata',
      status: 'Menunggu',
      waktuMasuk: '08:18',
      idTransaksi: '1005',
      idAntrian: 6,
    ),
  ];
}

// Helper untuk hitung statistik
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
