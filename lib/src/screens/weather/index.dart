import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:objectbox_flutter/src/bloc/weather_bloc.dart';
import 'package:objectbox_flutter/src/widgets/weather_box.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String cityName = "jabalpur";
  Stream? weatherStream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder(
              bloc: BlocProvider.of<WeatherBloc>(context)
                ..add(StartEvent(cityName: cityName)),
              builder: (context, state) {
                if (state is WeatherUninitializedState) {
                  return const CircularProgressIndicator();
                } else if (state is WeatherErrorState) {
                  return const Text("Something went wrong");
                } else if (state is WeatherFetchingState) {
                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));
                } else {
                  final stateAsWeatherFetchedState =
                      state as WeatherFetchedState;
                  return WeatherBox(
                      weather: stateAsWeatherFetchedState.weather);
                }
              })
        ],
      ),
    ));
  }
}