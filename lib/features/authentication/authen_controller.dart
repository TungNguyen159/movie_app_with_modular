import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/service/auth_service.dart';
import 'package:movie_app2/service/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenController extends Disposable {
  final AuthService authService;
  final UserService userService;
  AuthenController(this.authService, this.userService);

  final TextEditingController emailSIController = TextEditingController();
  final TextEditingController passwordSIController = TextEditingController();

  Future<void> login({
    required Function() onSuccess,
    required Function(String message) onError,
  }) async {
    final email = emailSIController.text;
    final password = passwordSIController.text;
    try {
      final response =
          await authService.signInWithEmailPassword(email, password);
      final userProfile = await userService.getUserbyid(response.user!.id);
      if (userProfile == null) {
        onError("Không tìm thấy tài khoản");
        return;
      }
      // Kiểm tra nếu user bị banned
      if (userProfile.status == "banned") {
        onError("Tài khoản của bạn đã bị ban. Vui lòng liên hệ hỗ trợ");
        return;
      }
      onSuccess();

    } catch (e) {
      if (e is AuthException) {
        onError("Đăng nhập thất bại vui lòng kiểm tra lại");
      } else {
        onError("Lỗi không xác định: $e");
      }
    }
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  Future<void> signup({
    required Function() onSuccess,
    required Function(String message) onError,
  }) async {
    final email = emailController.text;
    final password = passwordController.text;
    final passwordConfirm = passwordConfirmController.text;
    final name = nameController.text;
    // Kiểm tra email đã tồn tại chưa
    final emailExists = await userService.isEmailExists(email);
    if (emailExists) {
      onError("Email đã tồn tại! Vui lòng nhập email khác.");
      return;
    }
    // Kiểm tra username đã tồn tại chưa
    final nameExists = await userService.isUsernameExists(name);
    if (nameExists) {
      onError("Username đã được sử dụng! Vui lòng chọn username khác.");
      return;
    }
    if (password != passwordConfirm) {
      onError("Mật khẩu không trùng");

      return;
    }
    try {
      final response =
          await authService.signUpWithEmailPassword(email, password);
      if (response.user != null) {
        // save database user
        await userService.insertUserProfile(name);
        onSuccess();
      }
    } catch (e) {
      onError("Lỗi không xác định: $e");
    }
  }

  final TextEditingController emailFGController = TextEditingController();

  Future<void> sendResetEmail(BuildContext context) async {
    final email = emailFGController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập email!")),
      );
      return;
    }

    try {
      await authService.resetpasswordforemail(email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email đặt lại mật khẩu đã được gửi!")),
      );
      Modular.to.pushNamed("/authen/reset", arguments: {'email': email});
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi: $error")),
      );
    }
  }

  final TextEditingController codeController = TextEditingController();
  final TextEditingController passwordConfirmRSController =
      TextEditingController();
  final TextEditingController passwordRSController = TextEditingController();
  Future<void> resetPassword(BuildContext context) async {
    final code = codeController.text.trim();
    final email = emailFGController.text.trim();
    final newPassword = passwordConfirmRSController.text.trim();
    final confirmPassword = passwordRSController.text.trim();

    if (code.isEmpty || newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin!")),
      );
      return;
    }
    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mật khẩu không trùng!")),
      );
      return;
    }
    try {
      await authService.verifyOtpAndResetPassword(email, code, newPassword);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mật khẩu đã được đặt lại thành công!")),
      );

      // Chuyển về trang đăng nhập
      Modular.to.pushNamed("/authen/signin");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi: $e")),
      );
    }
  }

  @override
  void dispose() {
    emailSIController.dispose();
    passwordSIController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    nameController.dispose();
    emailFGController.dispose();
    codeController.dispose();
    passwordConfirmRSController.dispose();
  }
}
