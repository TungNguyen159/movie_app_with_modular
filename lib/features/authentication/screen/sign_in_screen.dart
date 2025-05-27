import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/Components/text_field_app.dart';
import 'package:movie_app2/Components/text_head.dart';
import 'package:movie_app2/Components/theme_helper.dart';
import 'package:movie_app2/core/theme/gap.dart';
import 'package:movie_app2/features/authentication/authen_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthenController controller = Modular.get<AuthenController>();
  final _formKey = GlobalKey<FormState>();
  void onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      controller.login(onSuccess: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Đăng nhập thành công")),
        );
        Modular.to.navigate("/");
      }, onError: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Column(
              children: [
                Image.asset(
                  getThemeImagePathWithController(
                    light: 'assets/8.png',
                    dark: 'assets/9.png',
                  ),
                  width: 300,
                  height: 300,
                ),
                Padding(
                  padding: const EdgeInsets.all(Gap.mL),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFieldApp(
                          hintText: "Email",
                          prefixIcon: const Icon(Icons.mail),
                          controller: controller.emailSIController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email cannot be empty";
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return "Invalid email format";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        Gap.mLHeight,
                        TextFieldApp(
                          hintText: "Password",
                          prefixIcon: const Icon(Icons.lock),
                          obscureText: true,
                          controller: controller.passwordSIController,
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return "Password cannot be empty";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                        ),
                        Gap.mdHeight,
                        ElevatedButton(
                          onPressed: () => onLoginPressed(),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(300, 60),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            elevation: 5,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: TextHead(
                            text: "login",
                            textStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onTertiary,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Gap.mLHeight,
                        TextButton(
                            onPressed: () {
                              Modular.to.pushNamed("/authen/forgot");
                            },
                            child: const Text('Forgot password?'))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            Modular.to.navigate("/authen/signup");
                          },
                          child: TextHead(
                            text: "Sign up",
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
