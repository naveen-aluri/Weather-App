import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/bloc/chart_values_bloc.dart';
import 'package:weatherapp/models/weather_history.dart';

class ForeCastList extends StatefulWidget {
  final List<ListElement> weatherList;
  ForeCastList({@required this.weatherList});

  @override
  _ForeCastListState createState() => _ForeCastListState();
}

class _ForeCastListState extends State<ForeCastList> {
  ScrollController _scrollController = new ScrollController();
  int itemIndex = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: chartValuesBloc.valueObservable,
        builder: (context, AsyncSnapshot<ChartValue> snapshot) {
          if (snapshot.hasData) {
            itemIndex = widget.weatherList
                .indexWhere((element) => element.dt == snapshot.data.dt);
            _scrollController.animateTo(itemIndex * 70.0,
                duration: new Duration(seconds: 2), curve: Curves.ease);
          }
          return SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              itemCount: widget.weatherList.length,
              itemBuilder: (context, index) => Card(
                color: itemIndex == index ? Colors.amber : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                          '${(widget.weatherList[index].temp.day - 273.15).round()}°C',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              letterSpacing: 1,
                              color: Colors.grey[400],
                              fontSize: 25)),
                      SizedBox(height: 5),
                      Text('${widget.weatherList[index].weather[0].main}',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              letterSpacing: 1,
                              color: Colors.black,
                              fontSize: 16)),
                      SizedBox(height: 5),
                      Text(
                          '${DateFormat('dd-MMM').format(DateTime.fromMillisecondsSinceEpoch(widget.weatherList[index].dt * 1000, isUtc: true))}',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              letterSpacing: 1,
                              color: Colors.black,
                              fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
