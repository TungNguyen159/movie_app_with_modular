import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/features/Checking/checking_route.dart';
import 'package:movie_app2/features/Checking/screen/checking_screen.dart';
import 'package:movie_app2/features/Checking/screen/confirmation_screen.dart';
import 'package:movie_app2/features/Checking/screen/payment_screen.dart';

class CheckingModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(CheckingRoute.rootMovie, child: (context) {
      final movieId = r.args.params["movieId"];
      return CheckingScreen(movieId: movieId);
    });
    r.child(CheckingRoute.rootPayment, child: (context) {
      return const PaymentScreen();
    });
    r.child(CheckingRoute.rootConfirm, child: (context) {
      return const ConfirmationScreen();
    });
  }
}
