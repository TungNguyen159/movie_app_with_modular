import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/features/Home/Home_page.dart';
import 'package:movie_app/features/Home/home_route.dart';
import 'package:movie_app/features/details/detail_route.dart';
import 'package:movie_app/features/details/detail_screen.dart';

class HomeModule extends Module {
  @override
  void binds(i) {}
  @override
  void routes(r) {
    r.child(HomeRoute.root, child: (ctx) => const HomePage());
    ChildRoute(DetailRoute.root,
        child: (ctx) =>
            DetailScreen(movieId: int.parse(r.args.queryParams['movieId']!)));
  }
}
