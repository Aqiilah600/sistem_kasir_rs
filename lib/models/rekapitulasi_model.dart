import 'package:flutter/material.dart';

class RekapitulasiData {
  final String label;
  final String value;
  final String subtitle;
  final IconData icon;

  RekapitulasiData({
    required this.label,
    required this.value,
    required this.subtitle,
    required this.icon,
  });
}

// Data dummy untuk hari ini
final List<RekapitulasiData> rekapitulasiHariIni = [
  RekapitulasiData(
    label: 'Total Pendapatan',
    value: 'Rp 520.000.00',
    subtitle: 'Hari ini',
    icon: Icons.receipt,
  ),
  RekapitulasiData(
    label: 'Jumlah Transaksi',
    value: '18 Transaksi',
    subtitle: 'Hari ini',
    icon: Icons.check_circle,
  ),
  RekapitulasiData(
    label: 'Jumlah Pasien',
    value: '18 Pasien',
    subtitle: 'Hari ini',
    icon: Icons.people,
  ),
];

// Data dummy untuk bulan ini
final List<RekapitulasiData> rekapitulasiBulanan = [
  RekapitulasiData(
    label: 'Total Pendapatan',
    value: 'Rp 520.000.00',
    subtitle: 'Bulan ini',
    icon: Icons.receipt,
  ),
  RekapitulasiData(
    label: 'Jumlah Transaksi',
    value: '18 Transaksi',
    subtitle: 'Bulan ini',
    icon: Icons.check_circle,
  ),
  RekapitulasiData(
    label: 'Jumlah Pasien',
    value: '18 Pasien',
    subtitle: 'Bulan ini',
    icon: Icons.people,
  ),
];
