import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/features/Tickets/ticket_page.dart';
import 'package:movie_app/features/Tickets/ticket_route.dart';
import 'package:movie_app/router/main_route.dart';

class TicketModule extends Module {
  @override
  void binds(Injector i) {
    // TODO: implement binds
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(MainRoute.root, child: (ctx) => TicketPage());
  }
}
