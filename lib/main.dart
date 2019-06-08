import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_list/weather_list.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
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

class WeatherPage extends StatefulWidget {
  WeatherPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  List<String> _weather = [];

  @override
  void initState() {
    super.initState();
    Future<Response> fetchPost() async {
  return get('https://api.openweathermap.org/data/2.5/weather?q=London,uk');
}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: Scaffold(
            appBar: AppBar(title: Text('Long List App')),
            body: Column(children: [
              Container(
                  margin: EdgeInsets.all(10.0),
                  child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      splashColor: Colors.blueGrey,
                      textColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          _weather.add('Laptop');
                        });
                      },
                      child: Text('MacBook'))),
              Expanded(child: WeatherList(_weather))
            ])));
  }
}
