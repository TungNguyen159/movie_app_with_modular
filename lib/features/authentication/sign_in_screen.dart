import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/app_elevated_button.dart';
import 'package:movie_app/Widgets/text_field_app.dart';
import 'package:movie_app/Widgets/text_head.dart';
import 'package:movie_app/features/Home/Home_page.dart';
import 'package:movie_app/features/authentication/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 50),
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
                AppElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => HomePage()));
                  },
                  text: "login",
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextHead(text: "no account? "),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => SignUpScreen()));
                  },
                  child: Text(
                    "Create account!",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
