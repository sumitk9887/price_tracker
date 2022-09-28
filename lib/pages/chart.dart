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
          color: const Color.fromARGB(255, 99, 235, 89),
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

  //List of dummy data for chart

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData(09.15, 2313.55),
      SalesData(10.15, 2329.60),
      SalesData(11.15, 2308.45),
      SalesData(12.15, 2315.00),
      SalesData(13.15, 2313.55),
      SalesData(14.15, 2329.60),
      SalesData(15.10, 2308.45),
      SalesData(15.15, 2315.00),
    ];
    return chartData;
  }
}

class SalesData {
  SalesData(this.time, this.price);
  final double time;
  final double price;
}
