import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/core/http/http.dart';

import 'home/module.dart';
import 'home/presentation/bloc_language/language_bloc.dart';
import 'home/presentation/bloc_theme/theme_bloc.dart';

class AppModule extends Module {
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
  }
}
