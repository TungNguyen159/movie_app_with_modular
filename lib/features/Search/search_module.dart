import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/features/Search/search_screen.dart';
import 'package:movie_app/router/main_route.dart';

class SearchModule extends Module {
  @override
  void binds(i) {}
  @override
  void routes(r) {
    r.child(MainRoute.root, child: (ctx) => const SearchScreen());
  }
}