import 'package:flutter/material.dart';
import 'package:objectbox_flutter/src/entity_model/weather_entity_model.dart';

class WeatherBox extends StatefulWidget {
  const WeatherBox({Key? key, required this.weather}) : super(key: key);
  final WeatherEntityModel weather;
  @override
  _WeatherBoxState createState() => _WeatherBoxState();
}

class _WeatherBoxState extends State<WeatherBox> {
  @override
  Widget build(BuildContext context) {
    final _weather = widget.weather;

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.all(10.0),
              child: Text(
                _weather.cityName,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
              )),
          Container(
              margin: const EdgeInsets.all(10.0),
              child: Text(
                "${_weather.temp}°C",
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
              )),
          Container(
              margin: const EdgeInsets.all(5.0),
              child: Text(_weather.description)),
          Container(
              margin: const EdgeInsets.all(5.0),
              child: Text("Feels:${_weather.feelsLike}°C")),
          Container(
              margin: const EdgeInsets.all(5.0),
              child: Text("H:${_weather.high}°C L:${_weather.low}°C")),
        ]);
  }
}
