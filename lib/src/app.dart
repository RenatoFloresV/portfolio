import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Importar para localización
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/generated/l10n.dart';
import 'package:portfolio_ds/lib.dart';

import '../global/widgets/geolocator/bloc_weather/weather_bloc.dart';
import 'home/presentation/bloc_icons/icons_bloc.dart';
import 'home/presentation/bloc_language/language_bloc.dart';
import 'home/presentation/bloc_theme/theme_bloc.dart'; // Asegúrate de que los archivos generados estén correctamente importados

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  Locale _locale = const Locale('en'); // Idioma por defecto

  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _MaterialRouter(
      locale: _locale,
      onLocaleChanged: _setLocale,
    );
  }
}

class _MaterialRouter extends StatelessWidget {
  final Locale locale;
  final void Function(Locale) onLocaleChanged;

  const _MaterialRouter({
    required this.locale,
    required this.onLocaleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "Noto Sans", "Noto Sans");
    PortfolioMaterialTheme theme = PortfolioMaterialTheme(textTheme);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => Modular.get<LanguageBloc>()),
        BlocProvider(create: (context) => Modular.get<ThemeBloc>()),
        BlocProvider(
            create: (context) => Modular.get<WeatherBloc>()
              ..add(const GetCurrentLocationEvent())),
        BlocProvider(create: (context) => Modular.get<IconBloc>()),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, languageState) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp.router(
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                title: 'Portfolio',
                locale: Locale(languageState.language),
                theme: state.themeMode,
                routerConfig: Modular.routerConfig,
                debugShowCheckedModeBanner: false,
              );
            },
          );
        },
      ),
    );
  }
}
