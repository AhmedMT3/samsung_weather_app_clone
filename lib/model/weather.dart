import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/model/forecast.dart';

class Weather {
  CurrentWeather currentWeather;
  ForecastWeather forecastWeather;
  Weather({
    required this.currentWeather,
    required this.forecastWeather,
  });
}
