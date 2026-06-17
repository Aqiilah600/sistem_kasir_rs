class RTransaksi {
  final String invoice;
  final String tanggal;
  final String pasien;
  final String poli;
  final String metode;

  RTransaksi({
    required this.invoice,
    required this.tanggal,
    required this.pasien,
    required this.poli,
    required this.metode,
  });

  factory RTransaksi.fromMap(Map<String, dynamic> data) {
    return RTransaksi(
      invoice: data['invoice'] ?? '',
      tanggal: data['tanggal'] ?? '',
      pasien: data['pasien'] ?? '',
      poli: data['poli'] ?? '',
      metode: data['metode'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'invoice': invoice,
      'tanggal': tanggal,
      'pasien': pasien,
      'poli': poli,
      'metode': metode,
    };
  }
}

class TransaksiService {
  // Simulasi data dummy dari API
  final List<Map<String, dynamic>> _dummyTransaksi = [
    {
      'invoice': 'INV-20260101-001',
      'tanggal': '01/01/2026',
      'pasien': 'Hafis Ridho',
      'poli': 'Poli Anak',
      'metode': 'Cash',
    },
    {
      'invoice': 'INV-20260101-002',
      'tanggal': '01/01/2026',
      'pasien': 'Ayuning',
      'poli': 'Poli Mata',
      'metode': 'Cash',
    },
    {
      'invoice': 'INV-20260101-003',
      'tanggal': '01/01/2026',
      'pasien': 'Nazwarni Aulia',
      'poli': 'Poli Gigi',
      'metode': 'Transfer',
    },
    {
      'invoice': 'INV-20260101-004',
      'tanggal': '02/01/2026',
      'pasien': 'Muzakir',
      'poli': 'Poli Gigi',
      'metode': 'Transfer',
    },
    {
      'invoice': 'INV-20260101-005',
      'tanggal': '02/01/2026',
      'pasien': 'Iki Jawir',
      'poli': 'Poli Jantung',
      'metode': 'Transfer',
    },
    {
      'invoice': 'INV-20260101-006',
      'tanggal': '04/01/2026',
      'pasien': 'Budi Santoso',
      'poli': 'Poli Dalam',
      'metode': 'Transfer',
    },
  ];

  // Fungsi untuk mengambil semua data (bisa diganti http.get nanti)
  Future<List<RTransaksi>> getAllTransaksi() async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Simulasi delay network
    return _dummyTransaksi.map((data) => RTransaksi.fromMap(data)).toList();
  }

  // Fungsi untuk pencarian data
  Future<List<RTransaksi>> searchTransaksi(String query) async {
    if (query.isEmpty) {
      return _dummyTransaksi.map((data) => RTransaksi.fromMap(data)).toList();
    }

    final results = _dummyTransaksi.where((item) {
      final pasien = item['pasien'].toString().toLowerCase();
      final invoice = item['invoice'].toString().toLowerCase();
      final searchLower = query.toLowerCase();

      return pasien.contains(searchLower) || invoice.contains(searchLower);
    }).toList();

    return results.map((data) => RTransaksi.fromMap(data)).toList();
  }
}
