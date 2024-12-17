import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/features/Favorites/favorite_module.dart';
import 'package:movie_app/features/Favorites/favorite_route.dart';
import 'package:movie_app/features/Home/home_module.dart';
import 'package:movie_app/features/Home/home_route.dart';
import 'package:movie_app/features/Onshowing/onshowing_module.dart';
import 'package:movie_app/features/Onshowing/onshowing_route.dart';
import 'package:movie_app/features/Search/search_module.dart';
import 'package:movie_app/features/Search/search_route.dart';
import 'package:movie_app/features/Settings/setting_module.dart';
import 'package:movie_app/features/Settings/setting_route.dart';
import 'package:movie_app/features/Tickets/ticket_module.dart';
import 'package:movie_app/features/Tickets/ticket_route.dart';
import 'package:movie_app/features/Tickets/ticket_screen.dart';
import 'package:movie_app/features/authentication/authen_module.dart';
import 'package:movie_app/features/authentication/authen_route.dart';
import 'package:movie_app/features/authentication/onboarding_screen.dart';
import 'package:movie_app/features/authentication/splash_logic.dart';
import 'package:movie_app/features/authentication/splash_module.dart';
import 'package:movie_app/features/details/detail_module.dart';
import 'package:movie_app/features/details/detail_route.dart';
import 'package:movie_app/router/bottom_bar.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    // TODO: implement binds
    super.binds(i);
  }

  String get initialRoute => '/splash/';
  @override
  void routes(r) {
    r.module("/", module: SplashModule());
    // r.module(AuthenRoute.root, module: AuthenModule());
    r.module(DetailRoute.root, module: DetailModule());
    r.module(SearchRoute.searchMovie, module: DetailModule());
    r.module(TicketRoute.root, module: TicketModule());
    r.module(TicketRoute.rootSearch, module: TicketModule());
    r.child("/main", child: (context) => const BottomBar(), children: [
      ModuleRoute(HomeRoute.root, module: HomeModule()),
      ModuleRoute(OnshowingRoute.root, module: OnshowingModule()),
      ModuleRoute(SearchRoute.root, module: SearchModule()),
      ModuleRoute(FavoriteRoute.root, module: FavoriteModule()),
      ModuleRoute(SettingRoute.root, module: SettingModule()),
    ]);

    // r.child("/", child: (context) => const SplashScreen(),children: [
    //   ChildRoute("/main", child: (context) => BottomBar(),children: []),
    // ]);
  }
}

  // @override
  // void routes(r) {
  //   r.child(MainRoute.root, child: (ctx) => const BottomBar());
  //   r.module(AuthenRoute.root, module: AuthenModule());
  //   r.module(HomeRoute.root, module: HomeModule());
  //   r.module(DetailRoute.root, module: DetailModule());
  //   r.module(SearchRoute.root, module: SearchModule());
  //   r.module(SettingRoute.root, module: SettingModule());
  //   r.module(TicketRoute.root, module: TicketModule());
  // }

