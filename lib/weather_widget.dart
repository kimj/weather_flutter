import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_list/objects/weather.dart';

class WeatherWidget extends StatelessWidget {
  WeatherWidget({Key key, this.title, this.weather}) : super(key: key);
  final String title;
  final Future<WeatherData> weather;

  Future<WeatherData> fetchWeather() async {
    final response = await http.get(
        'https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      var data = WeatherData.fromJson(json.decode(response.body));
      return data;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherData>(
        future: fetchWeather(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
                children: <Widget>[drawCurrentWeather(snapshot.data)]);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner
          return CircularProgressIndicator();
        });
  }

  Widget drawWeather(WeatherData data) {
    return Expanded(
        child: Column(
          children: <Widget>[
            Text(
              data.name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Text(data.main.temp.toString()),
            Text(data.main.tempMin.toString() +
                ' / ' +
                data.main.tempMax.toString()),
            Text(data.main.humidity.toString()),
            Text(data.main.pressure.toString()),
          ],
        ));
  }

  Widget drawCurrentWeather(WeatherData data) {
    return Expanded(
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                data.name.toString(),
                style: TextStyle(
                  fontSize: 34,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(data.dt.toString() + 'º',
                  style: TextStyle(
                    fontSize: 9,
                    color: Colors.black,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(width: 9),
              Text(data.weather[0].main,
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                  )),
            ],
          ),


          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("Wind",
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.black,
                          )),
                      Text(data.wind.speed.toString() + 'km/h',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          )),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text("Pressure",
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.black,
                          )),
                      Text(data.main.pressure.toString() + 'kPa',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          )),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text("Humidity",
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.black,
                          )),
                      Text(data.main.humidity.toString() + "%",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ]),
          )
        ]));
  }
}
