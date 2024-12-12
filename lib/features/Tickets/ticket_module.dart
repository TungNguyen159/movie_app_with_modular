import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/features/Tickets/ticket_screen.dart';
import 'package:movie_app/router/main_route.dart';

class TicketModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(MainRoute.root, child: (ctx) => const TicketScreen());
  }
}
