import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheatherio/weather/weather.dart';

void main() {
  const WeatherRepository weatherRepository = WeatherRepository();
  runApp(const WheatherioApp(weatherRepository: weatherRepository));
}

class WheatherioApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  const WheatherioApp({Key? key, required this.weatherRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        title: 'Weatherio',
        home: WeatherioView(weatherRepository: weatherRepository));
  }
}

class WeatherioView extends StatelessWidget {
  final WeatherRepository weatherRepository;

  const WeatherioView({Key? key, required this.weatherRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: BlocProvider(
      create: (_) => WeatherBloc(weatherRepository: weatherRepository),
      child: const WeatherMainView(),
    ));
  }
}
