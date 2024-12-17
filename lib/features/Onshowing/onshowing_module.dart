import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/features/Onshowing/onshowing_screen.dart';
import 'package:movie_app/router/main_route.dart';

class OnshowingModule extends Module {
  @override
  void binds(Injector i) {
    // TODO: implement binds
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(MainRoute.root, child: (ctx) => const OnshowingScreen());
  }
}
