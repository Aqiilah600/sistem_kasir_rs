// Lokasi: lib/utils/formatter.dart

const List<String> _namaBulanIndo = [
  '',
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'Mei',
  'Jun',
  'Jul',
  'Agu',
  'Sep',
  'Okt',
  'Nov',
  'Des',
];

/// Format angka menjadi "Rp 1.150.000"
String formatRupiah(double value) {
  final intValue = value.round();
  final str = intValue.toString();
  final buffer = StringBuffer();

  for (int i = 0; i < str.length; i++) {
    final posFromRight = str.length - i;
    buffer.write(str[i]);
    if (posFromRight > 1 && posFromRight % 3 == 1) {
      buffer.write('.');
    }
  }

  return 'Rp $buffer';
}

/// Format angka ringkas untuk sumbu Y grafik, contoh: 1.000.000
String formatRupiahRingkas(double value) {
  final str = value.round().toString();
  final buffer = StringBuffer();

  for (int i = 0; i < str.length; i++) {
    final posFromRight = str.length - i;
    buffer.write(str[i]);
    if (posFromRight > 1 && posFromRight % 3 == 1) {
      buffer.write('.');
    }
  }

  return buffer.toString();
}

/// Format tanggal menjadi "24 Mei"
String formatTanggalSingkat(DateTime date) {
  return '${date.day} ${_namaBulanIndo[date.month]}';
}
