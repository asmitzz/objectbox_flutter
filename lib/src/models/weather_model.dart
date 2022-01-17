class WeatherModel {
  final double temp;
  final double feelsLike;
  final double low;
  final double high;
  final String description;
  final String cityName;

  WeatherModel(
      {required this.temp,
      required this.feelsLike,
      required this.low,
      required this.cityName,
      required this.high,
      required this.description});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temp: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      low: json['main']['temp_min'].toDouble(),
      high: json['main']['temp_max'].toDouble(),
      description: json['weather'][0]['description'],
    );
  }

  static Map<String, dynamic> toJson(WeatherModel weather) {
    return {
      "name": weather.cityName,
      "temp": weather.temp,
      "feels_like": weather.feelsLike,
      "low": weather.low,
      "high": weather.high,
      "description": weather.description,
    };
  }
}
