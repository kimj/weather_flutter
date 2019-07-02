import 'package:flutter/material.dart';
import 'package:weather_list/weather_widget.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  WeatherApp({Key key}) : super(key: key);
  final String _title = 'Today\'s Weather';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        home: Scaffold(
          appBar: AppBar(title: Text(_title)),
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/london-bridge.jpg"),
                    fit: BoxFit.cover)),
            child: WeatherWidget(),
          ),
        );,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ));
  }
}