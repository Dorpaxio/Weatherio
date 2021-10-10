import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wheatherio/weather/models/weather_model.dart';
import 'package:wheatherio/weather/repositories/weather_repository.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
    on<WeatherFetch>(_onFetch);
  }

  void _onFetch(WeatherFetch event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final WeatherModel weatherModel =
          await weatherRepository.getWeather(event.city);
      emit(WeatherLoaded(weatherModel: weatherModel));
    } catch (e) {
      emit(WeatherError());
    }
  }
}
