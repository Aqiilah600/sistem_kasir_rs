class AntrianModel {
  final String nomor;
  final String nama;
  final String poli;
  String status;

  AntrianModel({
    required this.nomor,
    required this.nama,
    required this.poli,
    this.status = 'Menunggu',
  });
}
