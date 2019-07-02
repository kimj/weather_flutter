import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_list/objects/weather.dart';

class WeatherWidget extends StatelessWidget {
  WeatherWidget({Key key, this.title, this.weather}) : super(key: key);
  final String title;
  final Future<WeatherData> weather;

  final TextStyle large = TextStyle(
    fontSize: 48,
    color: Colors.white,
  );

  final TextStyle medium = TextStyle(
    fontSize: 36,
    color: Colors.white,
  );

  final TextStyle small = TextStyle(
    fontSize: 24,
    color: Colors.white,
  );

  Future<WeatherData> _fetchWeather() async {
    final response = await http.get(
        'https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      var data = WeatherData.fromJson(json.decode(response.body));
      return data;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load weather');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherData>(
        future: _fetchWeather(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(children: <Widget>[drawWeather(snapshot.data)]);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner
          return CircularProgressIndicator();
        });
  }

  int _toFahrenheit(double temp) {
    return ((temp - 273.15) * 9 / 5 + 32).toInt();
  }

  Widget drawWeather(WeatherData data) {
    return Expanded(
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(child:
              Text(data.name.toString(), style: large),
                  padding: EdgeInsets.all(16.0)
              )

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(_toFahrenheit(data.main.temp).toString(),
                  style: TextStyle(fontSize: 72.0, color: Colors.white)),
              Text('ºF', style: TextStyle(fontSize: 36.0, color: Colors.white))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(width: 9),
              Text(
                  _toFahrenheit(data.main.tempMin).toString() +
                      'ºF / ' +
                      _toFahrenheit(data.main.tempMax).toString() +
                      'ºF',
                  style: medium),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text("Wind",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            )),
                        Text(data.wind.speed.toString() + 'km/h',
                            style: medium),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text("Pressure",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            )),
                        Text(data.main.pressure.toString() + 'kPa',
                            style: medium),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text("Humidity",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            )),
                        Text(data.main.humidity.toString() + "%",
                            style: medium),
                      ],
                    ),
                  ),
                ]),
          )
        ]));
  }
}
