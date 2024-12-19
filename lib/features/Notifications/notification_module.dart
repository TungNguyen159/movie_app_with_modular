import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/features/Notifications/notification_screen.dart';
import 'package:movie_app/router/main_route.dart';

class NotificationModule extends Module {
  @override
  void binds(i) {}
  @override
  void routes(r) {
    r.child(MainRoute.root, child: (ctx) => const NotificationScreen());
  }
}
