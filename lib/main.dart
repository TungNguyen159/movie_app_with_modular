import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/app_module.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const MyApp()));
  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor:const Color.fromARGB(255, 0, 25, 58),
      ),
      routerConfig: Modular.routerConfig,
      //home: SignInScreen(),
    );
  }
}
