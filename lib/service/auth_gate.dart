import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/features/authentication/screen/onboarding_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final session = snapshot.data?.session;

        if (session != null) {
          // Sử dụng Future.microtask để tránh lỗi trong build
          Future.microtask(() => Modular.to.navigate("/main"));
          return const Scaffold(); // Trả về scaffold trống tạm thời
        } else {
          return const OnboardingScreen();
        }
      },
    );
  }
}
