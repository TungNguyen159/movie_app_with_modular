import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/config/api_handle.dart';
import 'package:movie_app/features/Checking/checking_module.dart';
import 'package:movie_app/features/Checking/checking_route.dart';
import 'package:movie_app/features/Home/home_controller.dart';
import 'package:movie_app/features/Home/home_module.dart';
import 'package:movie_app/features/Home/home_route.dart';
import 'package:movie_app/features/Settings/setting_module.dart';
import 'package:movie_app/features/Settings/setting_route.dart';
import 'package:movie_app/features/Tickets/ticket_module.dart';
import 'package:movie_app/features/Tickets/ticket_route.dart';
import 'package:movie_app/features/authentication/authen_module.dart';
import 'package:movie_app/features/authentication/authen_route.dart';
import 'package:movie_app/features/authentication/onboarding_screen.dart';
import 'package:movie_app/features/authentication/splash_logic.dart';
import 'package:movie_app/features/authentication/splash_module.dart';
import 'package:movie_app/features/details/detail_controller.dart';
import 'package:movie_app/features/details/detail_module.dart';
import 'package:movie_app/features/details/detail_route.dart';
import 'package:movie_app/router/bottom_bar.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(ControllerApi.new);
    i.addSingleton(HomeController.new);
  }

  String get initialRoute => '/';
  @override
  void routes(r) {
    r.module("/", module: SplashModule());
    r.module(AuthenRoute.root, module: AuthenModule());
    r.module(HomeRoute.root, module: HomeModule());
    r.module(DetailRoute.root, module: DetailModule());
    r.module(TicketRoute.root, module: TicketModule());
    r.module(CheckingRoute.root, module: CheckingModule());
    r.module(SettingRoute.root, module: SettingModule());
    r.child("/main", child: (context) => const BottomBar());
  }
}
