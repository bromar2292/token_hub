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
    double minPrice = cryptoDataList.first.price;
    double maxPrice = cryptoDataList.first.price;

    for (var dataPoint in cryptoDataList) {
      minPrice = min(minPrice, dataPoint.price);
      maxPrice = max(maxPrice, dataPoint.price);
    }
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
                dotData: const FlDotData(
                  show: false,
                ),
              ),
            ],
            borderData: FlBorderData(
              border: const Border(
                bottom: BorderSide(),
                left: BorderSide(),
              ),
            ),
            gridData: const FlGridData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: _bottomTitles,
              )),
              leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: _sideTitles,
                      interval: calculateInterval(
                          minPrice, maxPrice, 2) // 10 = desired labels

                      )),
              topTitles: const AxisTitles(
                  sideTitles: SideTitles(
                showTitles: false,
              )),
              rightTitles: const AxisTitles(
                  sideTitles: SideTitles(
                showTitles: false,
              )),
            ),
          ),
        ));
  }

  double calculateInterval(
      double minPrice, double maxPrice, int desiredLabels) {
    double priceRange = maxPrice - minPrice;
    return priceRange / desiredLabels;
  }

  Widget _sideTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.bold,
    );

    String formattedValue;
    if (value >= 1000) {
      formattedValue = '\$${NumberFormat.compact().format(value)}';
    } else if (value >= 1) {
      formattedValue = '\$${value.toStringAsFixed(2)}';
    } else {
      formattedValue = '\$${value.toStringAsExponential(2)}';
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(formattedValue, style: style),
    );
  }

  Widget _bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
    );

    DateTime currentDate =
        DateTime.fromMillisecondsSinceEpoch(value.toInt(), isUtc: true);
    DateTime todayDate = DateTime.now();

    if (currentDate.year == todayDate.year &&
        currentDate.month == todayDate.month &&
        currentDate.day == todayDate.day) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text('${currentDate.day}/${currentDate.month}', style: style),
      );
    }

    if (currentDate.day % 2 != 0) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text('${currentDate.day}/${currentDate.month}', style: style),
      );
    } else {
      return Container();
    }
  }
}
