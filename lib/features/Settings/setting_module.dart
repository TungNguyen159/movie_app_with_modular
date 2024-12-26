import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/features/Settings/screen/Edit_screen.dart';
import 'package:movie_app/features/Settings/screen/favorite_screen.dart';
import 'package:movie_app/features/Settings/screen/notification_screen.dart';
import 'package:movie_app/features/Settings/screen/setting_screen.dart';
import 'package:movie_app/features/Settings/setting_route.dart';
import 'package:movie_app/router/main_route.dart';

class SettingModule extends Module {
  @override
  void binds(i) {}
  @override
  void routes(r) {
    r.child(MainRoute.root, child: (ctx) => const SettingScreen());
    r.child(SettingRoute.rootEdit, child: (ctx) => const EditScreen());
    r.child(SettingRoute.rootfavourite, child: (ctx) => const FavoriteScreen());
    r.child(SettingRoute.rootnotificate, child: (ctx) => const NotificationScreen());
  }
}
