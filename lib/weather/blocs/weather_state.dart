part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  final String? city;
  const WeatherState({this.city});
  @override
  List<Object?> get props => [city];
}

class WeatherInitial extends WeatherState {}
class WeatherLoading extends WeatherState {}
class WeatherLoaded extends WeatherState {
  final WeatherModel weatherModel;
  const WeatherLoaded({required this.weatherModel});
}
class WeatherError extends WeatherState {}
