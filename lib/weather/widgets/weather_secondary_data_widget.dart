import 'package:flutter/cupertino.dart';
import 'package:wheatherio/weather/models/weather_model.dart';

class WeatherSecondaryData extends StatelessWidget {
  final WeatherList weather;
  final bool detailed;

  const WeatherSecondaryData(
      {Key? key, required this.weather, this.detailed = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> datas = [];
    datas.add(_getDataColumnElement(
        '${weather.wind!.speed!.toInt()} km/h', CupertinoIcons.wind));
    if (detailed) {
      datas.add(_getDataColumnElement(
          '${weather.wind!.deg!} deg', CupertinoIcons.compass));
    }
    datas.add(_getDataColumnElement(
        '${weather.main!.humidity!}%', CupertinoIcons.drop));
    return Wrap(spacing: 10, alignment: WrapAlignment.center, children: datas);
  }

  Widget _getDataColumnElement(String data, IconData icon) {
    return Column(children: [
      Text(data,
          style: const TextStyle(fontWeight: FontWeight.w200, fontSize: 14)),
      Icon(icon, size: 20, color: const Color.fromARGB(100, 0, 0, 0))
    ]);
  }
}
