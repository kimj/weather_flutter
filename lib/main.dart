import 'package:flutter/material.dart';

import 'package:weather_list/forecast_widget.dart';
import 'package:weather_list/weather_widget.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  WeatherApp({Key key}) : super(key: key);
  final String _title = 'Today\'s Weather';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        home: HomeWidget(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ));
  }
}

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeWidget> {
  int _currentIndex = 0;

  static TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _children = <Widget>[
    WeatherWidget(),
    ForecastWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: _children.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Weather'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Forecast'),
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
