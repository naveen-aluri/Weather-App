import 'package:rxdart/rxdart.dart';

class ChartValuesBloc {
  ChartValue chartValue = new ChartValue(dt: null);
  var serviceFetcher = PublishSubject<ChartValue>();
  ChartValuesBloc({this.chartValue}) {
    serviceFetcher.sink.add(chartValue);
  }

  Stream<ChartValue> get valueObservable => serviceFetcher.stream;

  void setValue(ChartValue value) {
    chartValue = value;
    serviceFetcher.add(value);
  }

  void dispose() async {
    serviceFetcher.close();
    serviceFetcher = null;
  }
}

final chartValuesBloc = ChartValuesBloc();

class ChartValue {
  int dt;
  ChartValue({this.dt});
}
