import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/features/Home/home_route.dart';
import 'package:movie_app2/features/Home/screens/all_screen.dart';
import 'package:movie_app2/features/Home/screens/genre_screen.dart';
import 'package:movie_app2/features/Home/screens/home_screen.dart';
import 'package:movie_app2/router/main_route.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
 
  }

  @override
  void routes(r) {
    r.child(MainRoute.root, child: (ctx) => const HomeScreen());
    r.child(HomeRoute.seeAll, child: (ctx) => const PopularScreen());
    r.child(HomeRoute.genres, child: (ctx) => const GenreScreen());
  }
}
