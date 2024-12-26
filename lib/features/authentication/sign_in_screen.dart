import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/Widgets/text_field_app.dart';
import 'package:movie_app/Widgets/text_head.dart';
import 'package:movie_app/features/authentication/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding:const EdgeInsets.symmetric(vertical: 50),
            child: Image.asset('actor_1.png'),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextFieldApp(
                  hintText: "Username",
                ),
                const TextFieldApp(
                  hintText: "Password",
                ),
                ElevatedButton(
                  onPressed: () {
                    Modular.to.navigate("/main");
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(400, 60),
                    backgroundColor: Colors.orange.withOpacity(0.2),
                    foregroundColor: Colors.white,
                    elevation: 5,
                    padding:const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  child: const Text("login"),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextHead(text: "no account? "),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) =>const SignUpScreen()));
                  },
                  child:const Text(
                    "Create account!",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
