import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/features/details/detail_route.dart';
import 'package:movie_app/features/details/detail_screen.dart';

class DetailModule extends Module {
  @override
  void binds(Injector i) {
    // TODO: implement binds
    super.binds(i);
  }
  @override
  void routes(RouteManager r) {
    r.child("${DetailRoute.root}/:movieId", child: (ctx) => DetailScreen(movieId: int.parse(r.args.queryParams['movieId']!) ));
  }
}
