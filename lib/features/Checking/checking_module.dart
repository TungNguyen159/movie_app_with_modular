import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/features/Checking/checking_screen.dart';

class SeatModule extends Module{
  @override
  void binds(Injector i) {
    // TODO: implement binds
    super.binds(i);
  }
  @override
  void routes(RouteManager r) {
    r.child("", child: (context) => const SeatScreen(movie: {}));
  }
}