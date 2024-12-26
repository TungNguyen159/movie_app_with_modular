import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/config/api_handle.dart';
import 'package:movie_app/features/Home/home_controller.dart';
import 'package:movie_app/features/Home/home_route.dart';
import 'package:movie_app/features/Home/screens/home_screen.dart';
import 'package:movie_app/features/Home/screens/all_screen.dart';
import 'package:movie_app/router/main_route.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(ControllerApi.new);
    i.addSingleton(HomeController.new);
  }

  @override
  void routes(r) {
    r.child(MainRoute.root, child: (ctx) => const HomeScreen());
    r.child(HomeRoute.seeAll, child: (ctx) => const PopularScreen());
  }
}
