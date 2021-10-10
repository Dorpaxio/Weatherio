import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheatherio/weather/blocs/weather_bloc.dart';
import 'package:wheatherio/weather/widgets/current_weather_widget.dart';
import 'package:wheatherio/weather/widgets/forecast_widget.dart';
import 'package:wheatherio/weather/widgets/location_infos_widget.dart';

class WeatherMainView extends StatelessWidget {
  const WeatherMainView({Key? key}) : super(key: key);

  void _changeCity(BuildContext context, String value) {
    BlocProvider.of<WeatherBloc>(context).add(WeatherFetch(city: value));
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (_, __) => [
              const CupertinoSliverNavigationBar(largeTitle: Text('Météo')),
              SliverToBoxAdapter(
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CupertinoSearchTextField(
                          onSubmitted: (value) => _changeCity(context, value))))
            ],
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocConsumer<WeatherBloc, WeatherState>(
                listener: (context, state) {
              if (state is WeatherError) {
                showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                          title: const Text('Erreur'),
                          content: const Text(
                              'Impossible de récupérer les données pour cette localisation. Vérifiez votre connexion internet.'),
                          actions: [
                            CupertinoDialogAction(
                                child: const Text('D\'accord'),
                                onPressed: () {
                                  Navigator.pop(context);
                                })
                          ],
                        ));
              }
            }, builder: (context, state) {
              if (state is WeatherInitial) {
                return _getInitialText(context);
              } else if (state is WeatherLoading) {
                return _getLoadingIndicator();
              } else if (state is WeatherError) {
                return _getInitialText(context);
              } else if (state is WeatherLoaded) {
                return SingleChildScrollView(
                    clipBehavior: Clip.none,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LocationInfos(weatherModel: state.weatherModel),
                          const SizedBox(height: 20),
                          CurrentWeather(weatherModel: state.weatherModel),
                          const SizedBox(height: 20),
                          Forecast(forecast: state.weatherModel.fourNextDays)
                        ]));
              }
              return const Text('Erreur');
            })));
  }

  Widget _getInitialText(BuildContext context) {
    return Center(
        child: Opacity(
            opacity: .5,
            child: Text('Cherchez une ville et observez sa météo.',
                textAlign: TextAlign.center,
                style: CupertinoTheme.of(context).textTheme.textStyle)));
  }

  Widget _getLoadingIndicator() {
    return const Center(child: CupertinoActivityIndicator(animating: true));
  }
}
