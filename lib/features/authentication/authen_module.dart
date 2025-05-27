import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/app.dart';
import 'package:movie_app2/features/authentication/screen/forgot_password.dart';
import 'package:movie_app2/features/authentication/screen/reset_password.dart';

import 'package:movie_app2/features/authentication/screen/sign_in_screen.dart';
import 'package:movie_app2/features/authentication/screen/sign_up_screen.dart';
import 'package:movie_app2/router/main_route.dart';
import 'package:movie_app2/service/auth_gate.dart';

class AuthenModule extends Module {
  @override
  void binds(Injector i) {
    // TODO: implement binds
    super.binds(i);
  }

  @override
  void routes(r) {
    r.child(MainRoute.root, child: (ctx) => const AuthGate());
    r.child(AuthenRoute.root, child: (ctx) => const OnboardingScreen());
    r.child(AuthenRoute.rootsingin, child: (ctx) => const SignInScreen());
    r.child(AuthenRoute.rootsingup, child: (ctx) => const SignUpScreen());
    r.child(AuthenRoute.rootforgot, child: (ctx) => const ForgotPassword());
    r.child(AuthenRoute.rootreset, child: (ctx) => const ResetPassword());
  }
}
