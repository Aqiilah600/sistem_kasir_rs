// Lokasi yang disarankan: lib/views/kasir/home/widgets/pendapatan_chart.dart

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:fl_chart/fl_chart.dart';
import '../../../models/dashboard_model.dart';
import '../../../../utils/formatter.dart';

/// Card berisi grafik garis "Pendapatan (Rp)" per tanggal.
///
/// Kasir dapat menekan/tap titik (dot) pada grafik untuk menampilkan
/// tooltip berisi tanggal & jumlah pendapatan pada titik tersebut,
/// contoh: "24 Mei  Rp 4.280.000".
class PendapatanChart extends StatelessWidget {
  final List<PendapatanHarian> data;

  const PendapatanChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 12, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(26),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Grafik Pendapatan',
            style: TextStyle(
              color: Color(0xFF006473),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          // LEGEND
          Row(
            children: [
              Container(
                width: 16,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'Pendapatan (Rp)',
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // CHART
          if (data.isEmpty)
            const SizedBox(
              height: 180,
              child: Center(
                child: Text(
                  'Belum ada data pendapatan',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            SizedBox(height: 220, child: _buildChart()),
        ],
      ),
    );
  }

  Widget _buildChart() {
    final spots = <FlSpot>[
      for (int i = 0; i < data.length; i++)
        FlSpot(i.toDouble(), data[i].pendapatan),
    ];

    final maxY = data.map((e) => e.pendapatan).reduce((a, b) => a > b ? a : b);
    // Beri sedikit ruang di atas titik tertinggi agar tooltip tidak terpotong
    final chartMaxY = maxY * 1.2;
    final interval = chartMaxY / 5;

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (data.length - 1).toDouble(),
        minY: 0,
        maxY: chartMaxY,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: interval,
          getDrawingHorizontalLine: (value) =>
              FlLine(color: Colors.grey.withOpacity(0.15), strokeWidth: 1),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            left: BorderSide(color: Colors.grey.withOpacity(0.25), width: 1),
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 60,
              interval: interval,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    formatRupiahRingkas(value),
                    style: TextStyle(fontSize: 9, color: Colors.grey[500]),
                    textAlign: TextAlign.right,
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              interval: 1,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= data.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    formatTanggalSingkat(data[index].tanggal),
                    style: TextStyle(fontSize: 9, color: Colors.grey[500]),
                  ),
                );
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: false,
            color: Colors.teal,
            barWidth: 3,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, bar, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.teal,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        // INTERAKSI: tap titik untuk menampilkan tooltip
        lineTouchData: LineTouchData(
          enabled: true,
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) => Colors.white,
            tooltipBorderRadius: BorderRadius.circular(8),
            tooltipPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final index = spot.x.toInt();
                final item = data[index];
                return LineTooltipItem(
                  '${formatTanggalSingkat(item.tanggal)}\n',
                  const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: formatRupiah(item.pendapatan),
                      style: const TextStyle(
                        color: Colors.teal,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              }).toList();
            },
          ),
          getTouchedSpotIndicator: (barData, spotIndexes) {
            return spotIndexes.map((index) {
              return TouchedSpotIndicatorData(
                FlLine(strokeWidth: 0, dashArray: [4, 4]),
                FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, bar, idx) =>
                      FlDotCirclePainter(radius: 6, color: Colors.teal),
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
