import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../pages/home.dart';

class LineChartWidget extends StatelessWidget {

  const LineChartWidget(this.points, this.transactions, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
                spots: [
                  (30,10)
                  (20,20)
                ],
                isCurved: false,
                dotData: FlDotData(
                  show: true,
                ),
                color: Colors.red),
            LineChartBarData(
              spots: [
                  (30,10)
                  (20,20)
                ],
              isCurved: false,
              dotData: FlDotData(
                show: true,
              ),
              color: const Color.fromARGB(255, 0, 35, 65),
            ),
          ],
          borderData: FlBorderData(
              border: const Border(bottom: BorderSide(), left: BorderSide())),
          gridData: FlGridData(show: true, drawVerticalLine: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: _bottomTitles),
            leftTitles: AxisTitles(sideTitles: _leftTitles),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.grey,
                tooltipRoundedRadius: 20.0,
                showOnTopOfTheChartBoxArea: true,
                fitInsideVertically: true,
                tooltipMargin: 0,
              ),
              getTouchedSpotIndicator:
                  (LineChartBarData barData, List<int> indicators) {
                return indicators.map(
                  (int index) {
                    final line = FlLine(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        strokeWidth: 1,
                        dashArray: [2, 4]);
                    return TouchedSpotIndicatorData(
                      line,
                      FlDotData(show: false),
                    );
                  },
                ).toList();
              },
              getTouchLineEnd: (_, __) => double.infinity),
        ),
      ),
    );
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 0:
              text = 'Jan';
              break;
            case 2:
              text = 'Mar';
              break;
            case 4:
              text = 'May';
              break;
            case 6:
              text = 'Jul';
              break;
            case 8:
              text = 'Sep';
              break;
            case 10:
              text = 'Nov';
              break;
          }

          return Text(text);
        },
      );

  SideTitles get _leftTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 0:
              text = '0';
              break;
            case 5:
              text = '5';
              break;
            case 10:
              text = '10';
              break;
            case 15:
              text = '15';
              break;
            case 20:
              text = '20';
              break;
            case 25:
              text = '25';
              break;
            case 30:
              text = '30';
              break;
          }

          return Text(text);
        },
      );
}
