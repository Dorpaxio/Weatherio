import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:wheatherio/weather/models/weather_model.dart';
import 'package:wheatherio/weather/widgets/weather_secondary_data_widget.dart';

class Forecast extends StatelessWidget {
  final List<WeatherList> forecast;

  const Forecast({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Prévision 5 jours',
        style: CupertinoTheme.of(context)
            .textTheme
            .textStyle
            .apply(fontSizeFactor: 1.7)
            .merge(const TextStyle(fontWeight: FontWeight.bold)),
      ),
      const SizedBox(height: 10),
      SingleChildScrollView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          child: Wrap(
              spacing: 10,
              children: forecast
                  .map((weatherList) => ForecastCard(
                        weatherList: weatherList,
                      ))
                  .toList()))
    ]);
  }
}

class ForecastCard extends StatelessWidget {
  final WeatherList weatherList;

  const ForecastCard({Key? key, required this.weatherList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String day = _getDayName(DateTime.parse(weatherList.dtTxt!).weekday);
    return Column(
      children: [
        Text(day,
            style: CupertinoTheme.of(context)
                .textTheme
                .textStyle
                .merge(const TextStyle(fontWeight: FontWeight.w200))),
        const SizedBox(height: 5),
        Container(
            padding: const EdgeInsets.all(10),
            width: 150,
            height: 150,
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
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Opacity(
                    opacity: .8,
                    child: Image.network(
                        "http://openweathermap.org/img/wn/${weatherList.weather![0].icon!}@2x.png")),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        weatherList.weather![0].description!.toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      Text('${(weatherList.main!.tempMax! - 273.15).toInt()}°C',
                          style: const TextStyle(fontWeight: FontWeight.w300)),
                      WeatherSecondaryData(
                          weather: weatherList, detailed: false)
                    ])
              ],
            )),
      ],
    );
  }

  String _getDayName(int weekDay) {
    switch (weekDay) {
      case 1:
        return 'Lundi';
      case 2:
        return 'Mardi';
      case 3:
        return 'Mercredi';
      case 4:
        return 'Jeudi';
      case 5:
        return 'Vendredi';
      case 6:
        return 'Samedi';
      default:
        return 'Dimanche';
    }
  }
}
