import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/text_field_app.dart';
import 'package:movie_app/Widgets/text_head.dart';
import 'package:movie_app/features/authentication/sign_in_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Image.asset('actor_1.png'),
          ),
          const Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldApp(
                  hintText: "Username",
                ),
                TextFieldApp(
                  hintText: "email",
                ),
                TextFieldApp(
                  hintText: "Password",
                ),
                TextFieldApp(
                  hintText: "Confirm password",
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextHead(text: "i already have account "),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => SignInScreen()));
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
