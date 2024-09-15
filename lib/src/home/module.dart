import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/page.dart';

class HomeModule extends Module {
  static String name = '/home';
  static String route = '/home/';

  @override
  void routes(r) {
    r.child('/', child: (_) => const HomeScreen());
  }
}
