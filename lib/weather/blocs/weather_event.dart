part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  final String city;
  const WeatherEvent({required this.city});

  @override
  List<Object?> get props => [city];
}

class WeatherFetch extends WeatherEvent {
  const WeatherFetch({required String city}) : super(city: city);
}
