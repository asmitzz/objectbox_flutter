import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:objectbox_flutter/objectbox.g.dart';
import 'package:objectbox_flutter/src/entity_model/weather_entity_model.dart';
import 'package:objectbox_flutter/src/models/weather_model.dart';
import 'package:objectbox_flutter/src/services/weather_service.dart';
import 'package:objectbox_flutter/src/widgets/weather_box.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String cityName = "jabalpur";
  WeatherEntityModel? weather;
  late Store _store;
  bool hasBeenInitialized = false;
  Stream? _weatherStream;
  late SharedPreferences prefs;

  final syncServerIp = "192.168.1.39";

  void saveWeatherModel(WeatherModel weather) {
    final _weatherModel = WeatherEntityModel(
        feelsLike: weather.feelsLike,
        low: weather.low,
        high: weather.high,
        description: weather.description,
        cityName: weather.cityName,
        temp: weather.temp);

    _store.box<WeatherEntityModel>().removeAll();
    _store.box<WeatherEntityModel>().put(_weatherModel);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    // Refreshing weather  in every 5seconds
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      prefs = await SharedPreferences.getInstance();
      if (!hasBeenInitialized && weather == null) {
        await getWeatherFromLocalStorage();
      }

      if (mounted) {
        final weatherService = WeatherService();
        Timer.periodic(const Duration(seconds: 5), (timer) async {
          // calling api
          WeatherModel weather =
              await weatherService.getCurrentWeather(cityName);

          // caching the weather
          saveWeatherModel(weather);

          // saving the weather in localStorage
          Map<String, dynamic> json = WeatherModel.toJson(weather);
          prefs.setString('weather', jsonEncode(json));
        });
      }
    });

    // getting the path of the directory and setting our store
    getApplicationDocumentsDirectory().then((dir) {
      _store = Store(
          // This method is from the generated file
          getObjectBoxModel(),
          directory: "${dir.path}/objectbox");
      Sync.client(_store, 'ws://$syncServerIp:9999', SyncCredentials.none())
          .start();
      _weatherStream = _store
          .box<WeatherEntityModel>()
          .query()
          .watch(triggerImmediately: true)
          .map((query) => query.find());

      setState(() {
        hasBeenInitialized = true;
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  @override
  void dispose() {
    _store.close();
    super.dispose();
  }

  Future<void> getWeatherFromLocalStorage() async {
    final localWeather = prefs.getString("weather");
    if (localWeather != null) {
      weather = WeatherEntityModel.fromJson(jsonDecode(localWeather));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder(
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (weather != null && !hasBeenInitialized) {
                return WeatherBox(weather: weather!);
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                final weather = snapshot.data[0] as WeatherEntityModel;
                return WeatherBox(weather: weather);
              } else if (snapshot.hasError) {
                return const Text("Error getting weather");
              } else {
                return const Text("No results found..");
              }
            },
            stream: _weatherStream,
          ),
        ],
      ),
    ));
  }
}
