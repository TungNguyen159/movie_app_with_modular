import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/features/Favorites/favorite.dart';
import 'package:movie_app/router/main_route.dart';

class FavoriteModule extends Module {
  @override
  void binds(i) {}
  @override
  void routes(r) {
    r.child(MainRoute.root, child: (ctx) => const FavoriteScreen());
  }
}
