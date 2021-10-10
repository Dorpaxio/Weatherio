import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:wheatherio/weather/models/weather_model.dart';
import 'package:wheatherio/weather/widgets/weather_secondary_data_widget.dart';

class CurrentWeather extends StatelessWidget {
  final WeatherModel weatherModel;

  const CurrentWeather({Key? key, required this.weatherModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Weather currentWeather = weatherModel.weatherList![0].weather![0];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Météo actuelle',
          style: CupertinoTheme.of(context)
              .textTheme
              .textStyle
              .apply(fontSizeFactor: 1.7)
              .merge(const TextStyle(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 10),
        Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      spreadRadius: .2,
                      offset: Offset(0, 2),
                      blurRadius: 20)
                ],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: [
                Image.network(
                    "http://openweathermap.org/img/wn/${currentWeather.icon!}@2x.png"),
                Text(currentWeather.description!.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                    '${(weatherModel.weatherList![0].main!.tempMin! - 273.15).toInt()}°C - ${(weatherModel.weatherList![0].main!.tempMax! - 273.15).toInt()}°C',
                    style: const TextStyle(fontWeight: FontWeight.w300)),
                const SizedBox(height: 10),
                WeatherSecondaryData(weather: weatherModel.weatherList![0])
              ],
            )),
      ],
    );
  }
}
