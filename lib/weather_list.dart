import 'package:flutter/material.dart';

class WeatherList extends StatelessWidget {
  final List<String> weeklyForecast;
  WeatherList(this.weeklyForecast);

  Widget _buildWeatherItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('assets/macbook.jpg'),
          Text(weeklyForecast[index], style: TextStyle(color: Colors.deepPurple))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildWeatherItem,
      itemCount: weeklyForecast.length,
    );
  }
}