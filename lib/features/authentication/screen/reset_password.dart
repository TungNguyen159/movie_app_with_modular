import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/Components/text_field_app.dart';
import 'package:movie_app2/core/theme/gap.dart';
import 'package:movie_app2/features/authentication/authen_controller.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final AuthenController controller = Modular.get<AuthenController>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFieldApp(
                hintText: "Code",
                controller: controller.codeController,
                prefixIcon: const Icon(Icons.lock),
                validator: (value) {
                  if (value == null) {
                    return "enter code";
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
                controller: controller.passwordRSController,
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
                controller: controller.passwordConfirmRSController,
                validator: (value) {
                  if (value != controller.passwordRSController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
                textInputAction: TextInputAction.done,
              ),
              Gap.mLHeight,
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    controller.resetPassword(context);
                  }
                },
                child: const Text("send"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
