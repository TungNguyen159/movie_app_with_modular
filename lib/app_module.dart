import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/features/Home/home_module.dart';
import 'package:movie_app/features/Home/home_route.dart';
import 'package:movie_app/features/Search/search_module.dart';
import 'package:movie_app/features/Search/search_route.dart';
import 'package:movie_app/features/Settings/setting_module.dart';
import 'package:movie_app/features/Settings/setting_route.dart';
import 'package:movie_app/features/Tickets/ticket_module.dart';
import 'package:movie_app/features/Tickets/ticket_route.dart';
import 'package:movie_app/features/details/detail_module.dart';
import 'package:movie_app/features/details/detail_route.dart';
import 'package:movie_app/router/bottom_bar.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    // TODO: implement binds
    super.binds(i);
  }

  @override
  void routes(r) {
    r.child("/", child: (context) => const BottomBar(), children: [
      ModuleRoute(HomeRoute.root, module: HomeModule()),
      ModuleRoute(DetailRoute.root, module: DetailModule()),
      ModuleRoute(SearchRoute.root, module: SearchModule()),
     // ModuleRoute(FavoriteRoute.root, module: FavoriteModule()),
      ModuleRoute(SettingRoute.root, module: SettingModule()),
      ModuleRoute(TicketRoute.root, module: TicketModule()),
    ]);
  }
}
