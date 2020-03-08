import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/models/weather_history.dart';

class ForeCastList extends StatelessWidget {
  final List<ListElement> weatherList;
  ForeCastList({@required this.weatherList});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherList.length,
        itemBuilder: (context, index) => Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text('${(weatherList[index].temp.day - 273.15).round()}°C',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1,
                        color: Colors.grey[400],
                        fontSize: 25)),
                SizedBox(height: 5),
                Text('${weatherList[index].weather[0].main}',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1,
                        color: Colors.black,
                        fontSize: 16)),
                SizedBox(height: 5),
                Text(
                    '${DateFormat('dd-MMM').format(DateTime.fromMillisecondsSinceEpoch(weatherList[index].dt * 1000, isUtc: true))}',
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
  }
}
