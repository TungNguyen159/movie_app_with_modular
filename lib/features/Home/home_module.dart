import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/features/Home/home_route.dart';
import 'package:movie_app/features/Home/home_screen.dart';
import 'package:movie_app/features/Home/popular.dart';
import 'package:movie_app/router/main_route.dart';


class HomeModule extends Module {
  @override
  void binds(i) {}
  @override
  void routes(r) {
    r.child(MainRoute.root, child: (ctx) => const HomeScreen());
    r.child(HomeRoute.seeAll, child: (ctx) => const PopularScreen());
  }
}
