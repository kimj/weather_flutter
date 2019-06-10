import 'package:flutter/material.dart';

class Weather extends StatelessWidget {
  final List<String> weather;
  Weather(this.weather);

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('assets/macbook.jpg'),
          Text(weather[index], style: TextStyle(color: Colors.deepPurple))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: weather.length,
    );
  }
}
