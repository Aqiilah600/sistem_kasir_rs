class RekapitulasiData {
  final String label;
  final String value;
  final String subtitle;

  RekapitulasiData({
    required this.label,
    required this.value,
    required this.subtitle,
  });
}

// Data dummy untuk hari ini (NANTI AKAN DARI API)
final List<RekapitulasiData> rekapitulasiHariIni = [
  RekapitulasiData(
    label: 'Total Pendapatan',
    value: 'Rp 520.000.00',
    subtitle: 'Hari ini',
  ),
  RekapitulasiData(
    label: 'Jumlah Transaksi',
    value: '18 Transaksi',
    subtitle: 'Hari ini',
  ),
  RekapitulasiData(
    label: 'Jumlah Pasien',
    value: '18 Pasien',
    subtitle: 'Hari ini',
  ),
];

// Data dummy untuk bulan ini (NANTI AKAN DARI API)
final List<RekapitulasiData> rekapitulasiBulanan = [
  RekapitulasiData(
    label: 'Total Pendapatan',
    value: 'Rp 520.000.00',
    subtitle: 'Bulan ini',
  ),
  RekapitulasiData(
    label: 'Jumlah Transaksi',
    value: '18 Transaksi',
    subtitle: 'Bulan ini',
  ),
  RekapitulasiData(
    label: 'Jumlah Pasien',
    value: '18 Pasien',
    subtitle: 'Bulan ini',
  ),
];
