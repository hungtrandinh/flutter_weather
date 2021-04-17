import 'package:equatable/equatable.dart';

import 'weather_condition.dart';

class Weather extends Equatable {
  final WeatherCondition condition;
  final String formattedCondition;
  final double minTemp;
  final double temp;
  final double maxTemp;
  final int locationId;
  final String created;
  final DateTime lastUpdated;
  final String location;
  final double wind_speed;
  final int humidity;
  final double air_pressure;

  const Weather(
      {this.condition,
      this.formattedCondition,
      this.minTemp,
      this.temp,
      this.maxTemp,
      this.locationId,
      this.created,
      this.lastUpdated,
      this.location,
      this.wind_speed,
      this.humidity,
      this.air_pressure});

  @override
  List<Object> get props => [
        condition,
        formattedCondition,
        minTemp,
        temp,
        maxTemp,
        locationId,
        created,
        lastUpdated,
        location,
        humidity,
        wind_speed,
        air_pressure
      ];

  static Weather fromJson(dynamic json) {
    final consolidatedWeather = json['consolidated_weather'];
    return Weather(
        condition: _mapStringToWeatherCondition(
          consolidatedWeather[0]['weather_state_abbr'],
        ),
        formattedCondition: consolidatedWeather[0]['weather_state_name'],
        minTemp: consolidatedWeather[0]['min_temp'] as double,
        temp: consolidatedWeather[0]['the_temp'] as double,
        maxTemp: consolidatedWeather[0]['max_temp'] as double,
        locationId: json['woeid'] as int,
        created: consolidatedWeather[0]['created'],
        lastUpdated: DateTime.now(),
        location: json['title'],
        humidity: consolidatedWeather[0]['humidity'] as int,
        wind_speed: consolidatedWeather[0]['wind_speed'] as double,
        air_pressure: consolidatedWeather[0]['air_pressure'] as double);
  }

  static WeatherCondition _mapStringToWeatherCondition(String input) {
    WeatherCondition state;
    switch (input) {
      case 'sn':
        state = WeatherCondition.snow;
        break;
      case 'sl':
        state = WeatherCondition.sleet;
        break;
      case 'h':
        state = WeatherCondition.hail;
        break;
      case 't':
        state = WeatherCondition.thunderstorm;
        break;
      case 'hr':
        state = WeatherCondition.heavyRain;
        break;
      case 'lr':
        state = WeatherCondition.lightRain;
        break;
      case 's':
        state = WeatherCondition.showers;
        break;
      case 'hc':
        state = WeatherCondition.heavyCloud;
        break;
      case 'lc':
        state = WeatherCondition.lightCloud;
        break;
      case 'c':
        state = WeatherCondition.clear;
        break;
      default:
        state = WeatherCondition.unknown;
    }
    return state;
  }
}
