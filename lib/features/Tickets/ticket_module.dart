import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/features/Tickets/ticket_route.dart';
import 'package:movie_app2/features/Tickets/ticket_screen.dart';

class TicketModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(TicketRoute.rootMovie, child: (context) {
      final movieId = r.args.params["movieId"];
      return TicketScreen(movieId:movieId);
    });
  }
}
