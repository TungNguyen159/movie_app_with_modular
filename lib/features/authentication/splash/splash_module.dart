import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/features/authentication/splash/splash_logic.dart';
import 'package:movie_app2/router/main_route.dart';

class SplashModule extends Module{
  @override
  void routes(RouteManager r) {
    r.child(MainRoute.root, child: (ctx) =>const SplashLogic());
  }
}