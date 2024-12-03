import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/features/Home/home_module.dart';
import 'package:movie_app/features/Home/home_route.dart';

class AppModule extends Module {

  @override
  void binds(Injector i) {
    // TODO: implement binds
    super.binds(i);
  }
  @override
  void routes(RouteManager r) {
    r.module(HomeRoute.root, module: HomeModule());
  }
}