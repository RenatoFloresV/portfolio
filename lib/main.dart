import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'src/app.dart';
import 'src/module.dart';

late GlobalKey<NavigatorState> globalNavigatorState;

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // const isRelease = bool.fromEnvironment('dart.vm.product');

      runApp(
        SafeArea(
          child: ModularApp(
            module: AppModule(),
            child: const AppWidget(),
          ),
        ),
      );
    },
    (exception, stackTrace) async {},
  );
}
