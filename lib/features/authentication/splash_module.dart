import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/features/authentication/splash_logic.dart';
import 'package:movie_app/router/main_route.dart';

class SplashModule extends Module{
  @override
  void routes(RouteManager r) {
    r.child(MainRoute.root, child: (ctx) => SplashLogic());
  }
}