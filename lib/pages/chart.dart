import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  const Chart({super.key, this.title});
  final String? title;
  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late List<SalesData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SfCartesianChart(
      tooltipBehavior: _tooltipBehavior,
      series: <FastLineSeries>[
        FastLineSeries<SalesData, double>(
          name: "Price",
          dataSource: _chartData,
          xValueMapper: (SalesData sales, _) => sales.time,
          xAxisName: "Price",
          yValueMapper: (SalesData sales, _) => sales.price,
          yAxisName: "Time",
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          enableTooltip: true,
          color: const Color.fromARGB(255, 77, 232, 66),
          width: 4,
          opacity: 1,
        )
      ],
      primaryXAxis: NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      primaryYAxis: NumericAxis(labelFormat: '₹{value}'),
    )));
  }

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData(09.15, 2313.55),
      SalesData(09.30, 2329.60),
      SalesData(09.45, 2308.45),
      SalesData(10.30, 2309.66),
      SalesData(10.45, 2308.45),
      SalesData(10.50, 2315.00),
      SalesData(11.15, 2303.15),
      SalesData(11.30, 2311.26),
      SalesData(11.45, 2366.2),
      SalesData(11.50, 2315.00),
      SalesData(12.15, 2313.55),
    ];
    return chartData;
  }
}

class SalesData {
  SalesData(this.time, this.price);
  final double time;
  final double price;
}
