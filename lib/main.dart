import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/app_controller.dart';
import 'package:movie_app2/app_module.dart';
import 'package:movie_app2/config/api_key.dart';
import 'package:movie_app2/core/theme/theme.dart';
import 'package:movie_app2/service/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    anonKey: ApiKey.anonKey,
    url: ApiKey.url,
  );
  runApp(ModularApp(module: AppModule(), child: const MyApp()));
  //runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    UserService().refreshUserSession();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<AppController>();

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Movie App',
          theme: lightTheme,
          darkTheme: dartkTheme,
          themeMode: controller.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          routerDelegate: Modular.routerDelegate,
          routeInformationParser: Modular.routeInformationParser,
        );
      },
    );
  }
}
