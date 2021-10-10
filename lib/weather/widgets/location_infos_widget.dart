import 'package:flutter/cupertino.dart';
import 'package:wheatherio/weather/models/weather_model.dart';

class LocationInfos extends StatelessWidget {
  final WeatherModel weatherModel;

  const LocationInfos({Key? key, required this.weatherModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    String formattedDate =
        "${today.day.toString().padLeft(2, '0')}/${today.month.toString().padLeft(2, '0')}/${today.year.toString()} - ${today.hour.toString().padLeft(2, '0')}:${today.minute.toString().padLeft(2, '0')}";
    return Column(children: [
      Text(weatherModel.city!.name!,
          style: CupertinoTheme.of(context)
              .textTheme
              .textStyle
              .apply(fontSizeFactor: 1.9)
              .merge(const TextStyle(fontWeight: FontWeight.bold))),
      Text(formattedDate,
          style: CupertinoTheme.of(context)
              .textTheme
              .textStyle
              .merge(const TextStyle(fontWeight: FontWeight.w200)))
    ]);
  }
}
