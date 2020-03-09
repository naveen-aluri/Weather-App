import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:weatherapp/bloc/chart_values_bloc.dart';
import 'package:weatherapp/models/weather_history.dart';

class ForeCastChart extends StatefulWidget {
  final List<ListElement> weatherList;
  ForeCastChart({@required this.weatherList});
  @override
  _ForeCastChartState createState() => _ForeCastChartState();
}

class _ForeCastChartState extends State<ForeCastChart> {
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: charts.TimeSeriesChart(
        _createData(),
        animate: false,
        defaultRenderer: new charts.LineRendererConfig(includePoints: true),
        secondaryMeasureAxis: new charts.NumericAxisSpec(
            tickProviderSpec: new charts.BasicNumericTickProviderSpec(
                zeroBound: false, desiredTickCount: 5)),
        domainAxis: new charts.DateTimeAxisSpec(
            tickProviderSpec: charts.DayTickProviderSpec(increments: [1, 2, 3]),
            tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
              day: new charts.TimeFormatterSpec(
                  format: 'dd',
                  noonFormat: 'dd-MMM',
                  transitionFormat: 'dd-MMM'),
            )),
        behaviors: [
          new charts.ChartTitle('Date',
              titleStyleSpec: charts.TextStyleSpec(
                  fontSize: 14, color: charts.MaterialPalette.black),
              innerPadding: 10,
              outerPadding: 0,
              behaviorPosition: charts.BehaviorPosition.bottom,
              titleOutsideJustification:
                  charts.OutsideJustification.middleDrawArea),
          new charts.ChartTitle('Temperature in °C',
              titleStyleSpec: charts.TextStyleSpec(fontSize: 14),
              innerPadding: 0,
              outerPadding: 15,
              titlePadding: 0,
              behaviorPosition: charts.BehaviorPosition.end,
              titleOutsideJustification:
                  charts.OutsideJustification.middleDrawArea),
        ],
        selectionModels: [
          new charts.SelectionModelConfig(
            type: charts.SelectionModelType.info,
            changedListener: _onSelectionChanged,
          )
        ],
      ),
    );
  }

  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    ChartValue chartValue = new ChartValue();
    chartValue.dt = selectedDatum[0].datum.data.dt;
    chartValuesBloc.setValue(chartValue);
  }

  /// Create one series with Weather data.
  List<charts.Series<TimeSeriesSales, DateTime>> _createData() {
    List<TimeSeriesSales> data = [];
    widget.weatherList.forEach((element) {
      DateTime date = new DateTime.fromMillisecondsSinceEpoch(element.dt * 1000,
          isUtc: true);
      data.add(TimeSeriesSales(
          DateTime(date.year, date.month, date.day, date.hour, date.minute),
          element));
    });

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'weather',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales weather, _) => weather.time,
        measureFn: (TimeSeriesSales weather, _) =>
            (weather.data.temp.day - 273.15).round(),
        data: data,
      )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
    ];
  }
}

class TimeSeriesSales {
  final DateTime time;
  final ListElement data;

  TimeSeriesSales(this.time, this.data);
}
