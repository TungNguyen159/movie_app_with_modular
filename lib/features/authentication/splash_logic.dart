import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
// import 'package:movie_app/Widgets/app_elevated_button.dart';
// import 'package:movie_app/features/authentication/authen_route.dart';

class SplashLogic extends StatelessWidget {
  const SplashLogic({super.key});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 3)); // Giả lập thời gian tải
      Modular.to.pushReplacementNamed('/main'); // Chuyển đến màn hình chính

      // final bool isAuthenticated = await checkAuthentication();
      // if (isAuthenticated) {
      // } else {
      //   Modular.to.pushReplacementNamed(
      //       AuthenRoute.root); // Chuyển đến màn hình đăng nhập
      // }
    });

    return const SplashScreen();
  }

  Future<bool> checkAuthentication() async {
    // Logic kiểm tra đăng nhập, giả lập bằng delay
    await Future.delayed(const Duration(seconds: 1));
    return false; // Giả lập chưa đăng nhập
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 100),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
