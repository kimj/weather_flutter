import 'package:flutter/material.dart';
import 'package:weather_list/forecast.dart';
import 'package:weather_list/weather.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class ForecastWidget extends StatelessWidget {

  final Forecast weeklyForecast;
  ForecastWidget(this.weeklyForecast);

  Widget _buildWeatherItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('assets/macbook.jpg'),
          Text(weeklyForecast.list.first.weather.first.description, style: TextStyle(color: Colors.deepPurple))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildWeatherItem,
      itemCount: weeklyForecast.list.length,
    );
  }

  Future<Forecast>  fetchForecast() async{
    final response =
      await http.get('https://samples.openweathermap.org/data/2.5/forecast/hourly?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    return Forecast.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }

}
}