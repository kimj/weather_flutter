import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_list/weather.dart';

void main() => runApp(WeatherApp());

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

class WeatherApp extends StatelessWidget {
  WeatherApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherPage(title: 'Weather'),
    );
  }
}

class WeatherPage extends StatelessWidget {
  WeatherPage({Key key, this.title, this.weather}) : super(key: key);
  final String title;
  final Future<WeatherData> weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Weather App')),
        body: Center(
            child: FutureBuilder<WeatherData>(
                future: fetchWeather(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(children: <Widget>[
                      drawWeather(snapshot.data)
                    ] );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner
                  return CircularProgressIndicator();
                })));
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
        Text(data.main.tempMin.toString() + ' / ' + data.main.tempMax.toString()),
        Text(data.main.humidity.toString()),
        Text(data.main.pressure.toString()),
      ],
    ));
  }
}
