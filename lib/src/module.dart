import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/core/http/http.dart';
import 'package:portfolio/global/widgets/geolocator/bloc_weather/weather_bloc.dart';
import 'package:portfolio/global/widgets/geolocator/data/data.dart';
import 'package:portfolio/global/widgets/geolocator/domain/domain.dart';
import 'package:portfolio/src/home/presentation/bloc_window/window_bloc.dart';
import 'package:portfolio/src/home/presentation/wallpaper_bloc/wallpaper_bloc.dart';

import '../core/local_storage/local_storage.dart';
import 'home/module.dart';
import 'home/presentation/bloc_icons/icons_bloc.dart';
import 'home/presentation/bloc_language/language_bloc.dart';
import 'home/presentation/bloc_theme/theme_bloc.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [GlobalCoreModule()];

  @override
  void binds(Injector i) {
    i.addSingleton<LanguageBloc>(
      LanguageBloc.new,
      config: BindConfig(
        onDispose: (bloc) => bloc.close(),
      ),
    );
    i.addSingleton<ThemeBloc>(
      ThemeBloc.new,
      config: BindConfig(
        onDispose: (bloc) => bloc.close(),
      ),
    );

    i.add<WeatherRepository>(
      WeatherRepositoryImpl.new,
    );
    i.addSingleton<WeatherBloc>(
      WeatherBloc.new,
      config: BindConfig(
        onDispose: (bloc) => bloc.close(),
      ),
    );

    i.addSingleton<IconBloc>(
      IconBloc.new,
      config: BindConfig(
        onDispose: (bloc) => bloc.close(),
      ),
    );
    i.addSingleton<WallpaperBloc>(
      WallpaperBloc.new,
      config: BindConfig(
        onDispose: (bloc) => bloc.close(),
      ),
    );
    i.addSingleton<WindowBloc>(
      WindowBloc.new,
      config: BindConfig(
        onDispose: (bloc) => bloc.close(),
      ),
    );
  }

  @override
  void routes(r) {
    r.module(HomeModule.name, module: HomeModule());
    r.redirect('/', to: HomeModule.route);
  }
}

class GlobalCoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addSingleton<PortfolioHttp>(PortfolioDioHttp.new);
    i.addSingleton(StorageService.new);
  }
}
