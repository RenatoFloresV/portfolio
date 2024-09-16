import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/generated/l10n.dart';
import 'package:portfolio_ds/portfolio_ds.dart';

import 'bloc_weather/weather_bloc.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final String noData = S.of(context).weatherNoData;
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state.status == WeatherStatus.showLoading) {
          return const CircularProgressIndicator();
        }

        if (state.status == WeatherStatus.error) {
          return const Text('Error al obtener el clima');
        }

        if (state.status == WeatherStatus.success) {
          final weather = state.weatherData;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network('https:${weather.current?.condition?.icon ?? ''}'),
              DsText(
                '${weather.current?.tempC?.toStringAsFixed(1) ?? '--'}°C',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: context.colors.white),
              ),
            ],
          );
        }

        return DsText(noData,
            style: TextStyle(
              fontSize: DsSpacing.md,
              fontWeight: FontWeight.w200,
              color: context.colors.white,
            ));
      },
    );
  }
}
