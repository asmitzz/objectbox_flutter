import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:objectbox_flutter/src/bloc/weather_bloc.dart';
import 'package:objectbox_flutter/src/repository/objectbox_repository.dart';
import 'package:objectbox_flutter/src/repository/weather_repository.dart';
import 'package:objectbox_flutter/src/screens/weather/index.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ObjectBoxRepository objectBoxRepository = ObjectBoxRepository();
  WeatherRepository weatherRepository = WeatherRepository();
  late WeatherBloc _weatherBloc;

  @override
  void initState() {
    super.initState();
    _weatherBloc = WeatherBloc(
        weatherRepository: weatherRepository,
        objectBoxRepository: objectBoxRepository);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _weatherBloc,
      child: const MaterialApp(
        home: WeatherScreen(),
      ),
    );
  }
}
