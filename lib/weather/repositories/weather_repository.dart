import 'package:wheatherio/weather/models/weather_model.dart';
import 'package:wheatherio/weather/services/weather_service.dart';

class WeatherRepository {
  const WeatherRepository();

  Future<WeatherModel> getWeather(String city) async {
    return WeatherService.getWeather(city);
  }
}
