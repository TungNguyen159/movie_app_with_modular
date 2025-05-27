import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/Components/theme_helper.dart';
import 'package:movie_app2/core/theme/gap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashLogic extends StatelessWidget {
  const SplashLogic({super.key});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 3)); // Giả lập thời gian tải

      final session = Supabase.instance.client.auth.currentSession;

      if (session != null) {
        Modular.to.pushReplacementNamed("/main"); // Nếu đã đăng nhập -> Main
      } else {
        Modular.to.pushReplacementNamed("/authen");
      }
    });

    return const SplashScreen();
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              getThemeImagePathWithController(
                light: 'assets/8.png',
                dark: 'assets/9.png',
              ),
              width: 300,
              height: 300,
            ),
            Gap.mdHeight,
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
