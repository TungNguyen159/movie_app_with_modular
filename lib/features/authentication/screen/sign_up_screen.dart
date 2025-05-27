import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/Components/text_field_app.dart';
import 'package:movie_app2/Components/text_head.dart';
import 'package:movie_app2/Components/theme_helper.dart';
import 'package:movie_app2/core/theme/gap.dart';
import 'package:movie_app2/features/authentication/authen_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthenController controller = Modular.get<AuthenController>();
  final _formKey = GlobalKey<FormState>();
  void onSignupPressed() {
    if (_formKey.currentState!.validate()) {
      controller.signup(onSuccess: () {
        // Chuyển hướng đến trang đăng nhập
        Modular.to.pushReplacementNamed("/authen/signin");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Đăng ký thành công"),
          ),
        );
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
                  height: 250,
                ),
                Padding(
                  padding: const EdgeInsets.all(Gap.mL),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFieldApp(
                          hintText: "Username",
                          prefixIcon: const Icon(Icons.person),
                          controller: controller.nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Username cannot be empty";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        Gap.mLHeight,
                        TextFieldApp(
                          hintText: "email",
                          prefixIcon: const Icon(Icons.mail),
                          controller: controller.emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email cannot be empty";
                            }
                            if (!RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                                    .hasMatch(value) ||
                                !value.endsWith("@gmail.com")) {
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
                          controller: controller.passwordController,
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        Gap.mLHeight,
                        TextFieldApp(
                          hintText: "Confirm password",
                          prefixIcon: const Icon(Icons.lock),
                          obscureText: true,
                          controller: controller.passwordConfirmController,
                          validator: (value) {
                            if (value != controller.passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                        ),
                        Gap.mdHeight,
                        ElevatedButton(
                          onPressed: () => onSignupPressed(),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(300, 60),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            elevation: 5,
                            padding:
                                const EdgeInsets.symmetric(vertical: Gap.sM),
                          ),
                          child: TextHead(
                            text: "Sign up",
                            textStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onTertiary,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        Modular.to.navigate("/authen/signin");
                      },
                      child: TextHead(
                        text: "Login",
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
