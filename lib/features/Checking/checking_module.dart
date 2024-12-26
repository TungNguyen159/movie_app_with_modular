import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/features/Checking/checking_route.dart';
import 'package:movie_app/features/Checking/screen/checking_screen.dart';

class CheckingModule extends Module{
  @override
  void binds(Injector i) {
    // TODO: implement binds
    super.binds(i);
  }
  @override
  void routes(RouteManager r) {
 r.child(CheckingRoute.rootMovie, child: (context) {
      final movieId = r.args.params["movieId"];
      return CheckingScreen(movie: {},movieId: int.parse(movieId));
    });
    // r.child(TicketRoute.rootMovie, child: (context) {
    //   final movieId = r.args.params["movieId"];
    //   return TicketScreen(movieId: int.parse(movieId));
    // });

  }
}