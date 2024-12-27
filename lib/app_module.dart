import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/app.dart';

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
