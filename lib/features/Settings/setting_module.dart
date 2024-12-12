import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/features/Settings/setting_screen.dart';
import 'package:movie_app/router/main_route.dart';

class SettingModule extends Module {
  @override
  void binds(i) {}
  @override
  void routes(r) {
    r.child(MainRoute.root, child: (ctx) => const SettingScreen());
  }
}
