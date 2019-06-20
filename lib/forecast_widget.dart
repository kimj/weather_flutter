import 'package:flutter/material.dart';
import 'package:weather_list/objects/forecast.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
class ForecastWidget extends StatelessWidget {
  Future<Forecast> weeklyForecast;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<Forecast>(
            future: fetchForecast(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: <Widget>[drawForecast(snapshot.data)
                ]);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner
              return CircularProgressIndicator();
            }));
  }
}

Widget drawForecast(Forecast forecast) {
  return SingleChildScrollView(child: ListView.builder(
      itemCount: forecast.list.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${forecast.list[index]}'),
          subtitle: Text('${forecast.list[index].weather}'),
          leading: CircleAvatar(
            backgroundImage: Icons.desktop_mac.,

            ),
          ),
        );
      }));
}

Future<Forecast> fetchForecast() async {
  final response = await http.get(
      'https://samples.openweathermap.org/data/2.5/forecast/hourly?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    return Forecast.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}