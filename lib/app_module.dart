import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/app.dart';
import 'package:movie_app2/app_controller.dart';
import 'package:movie_app2/features/authentication/authen_controller.dart';
import 'package:movie_app2/service/auth_service.dart';
import 'package:movie_app2/service/user_service.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addInstance(AuthService());
    i.addInstance(UserService());
    i.addSingleton(AppController.new);
    i.addSingleton<AuthenController>(
        () => AuthenController(i.get<AuthService>(), i.get<UserService>()));
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
    r.module(ManageRoute.root, module: ManageModule());
    r.child("/main", child: (context) => const BottomBar());
  }
}
