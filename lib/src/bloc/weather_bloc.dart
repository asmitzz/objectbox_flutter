import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:objectbox_flutter/src/entity_model/weather_entity_model.dart';
import 'package:objectbox_flutter/src/models/weather_model.dart';
import 'package:objectbox_flutter/src/repository/objectbox_repository.dart';
import 'package:objectbox_flutter/src/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  final ObjectBoxRepository objectBoxRepository;

  fetchWeather({emit, cityName}) async {
    WeatherModel weather;
    try {
      weather = await weatherRepository.fetchWeather(cityName);
      add(CacheWeatherEvent(weather: weather));
    } catch (e) {
      emit(WeatherErrorState());
    }
  }

  saveWeatherModel({required WeatherModel weather, required emit}) async {
    emit(WeatherFetchingState());
    final _weatherModel = WeatherEntityModel(
        feelsLike: weather.feelsLike,
        low: weather.low,
        high: weather.high,
        description: weather.description,
        cityName: weather.cityName,
        temp: weather.temp);

    if (objectBoxRepository.hasStoreInitialized) {
      objectBoxRepository.store.box<WeatherEntityModel>().removeAll();
      objectBoxRepository.store.box<WeatherEntityModel>().put(_weatherModel);
      final WeatherEntityModel getWeather =
          objectBoxRepository.store.box<WeatherEntityModel>().getAll()[0];
      emit(WeatherFetchedState(weather: getWeather));
    }
  }

  WeatherBloc(
      {required this.weatherRepository, required this.objectBoxRepository})
      : super(WeatherUninitializedState()) {
    on<WeatherEvent>((event, emit) async {
      if (event is StartEvent) {
        emit(WeatherFetchingState());
        await objectBoxRepository.init();

        final List<WeatherEntityModel> listOfWeather =
            objectBoxRepository.store.box<WeatherEntityModel>().getAll();

        if (listOfWeather.isNotEmpty) {
          final getWeather = listOfWeather[0];
          emit(WeatherFetchedState(weather: getWeather));
        }

        add(FetchWeatherEvent(cityName: event.cityName));

        Timer.periodic(const Duration(seconds: 5), (timer) {
          add(FetchWeatherEvent(cityName: event.cityName));
        });
      }
      if (event is FetchWeatherEvent) {
        await fetchWeather(emit: emit, cityName: event.cityName);
      }
      if (event is CacheWeatherEvent) {
        await saveWeatherModel(emit: emit, weather: event.weather);
      }
    });
  }

  @override
  void onTransition(Transition<WeatherEvent, WeatherState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  WeatherState get initialState => WeatherUninitializedState();
}
