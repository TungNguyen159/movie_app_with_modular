import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/Components/text_field_app.dart';
import 'package:movie_app2/core/theme/gap.dart';
import 'package:movie_app2/features/authentication/authen_controller.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final AuthenController controller = Modular.get<AuthenController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Enter your email to receive password reset code",
              textAlign: TextAlign.center,
            ),
            Gap.mLHeight,
            Form(
              key: _formKey,
              child: TextFieldApp(
                hintText: "email",
                prefixIcon: const Icon(Icons.mail),
                controller: controller.emailFGController,
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
              ),
            ),
            Gap.mLHeight,
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  controller.sendResetEmail(context);
                }
              },
              child: const Text("Gửi email đặt lại mật khẩu"),
            ),
          ],
        ),
      ),
    );
  }
}
