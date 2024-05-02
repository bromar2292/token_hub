import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/crypto_price_data_model.dart';

class PriceChart extends StatelessWidget {
  final List<CryptoPriceData> cryptoDataList;

  const PriceChart({Key? key, required this.cryptoDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: cryptoDataList
                  .map((point) => FlSpot(point.date.toDouble(), point.price))
                  .toList(),
              isCurved: true,
              color: Colors.green,
              dotData: FlDotData(
                show: false,
              ),
            ),
          ],
          borderData: FlBorderData(
              border: const Border(bottom: BorderSide(), left: BorderSide())),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: _bottomTitles),
            leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        ),
      ),
    );
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 1:
              text = 'march';
              break;
            case 3:
              text = 'april';
              break;
            case 5:
              text = 'May';
              break;
          }

          return Text(text);
        },
      );
}
