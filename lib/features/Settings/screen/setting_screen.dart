import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/Components/alert_dialog.dart';
import 'package:movie_app2/Components/app_button.dart';
import 'package:movie_app2/Components/text_head.dart';
import 'package:movie_app2/app_controller.dart';
import 'package:movie_app2/core/theme/gap.dart';
import 'package:movie_app2/features/Settings/widgets/custom_profile.dart';
import 'package:movie_app2/models/user.dart';
import 'package:movie_app2/service/auth_service.dart';
import 'package:movie_app2/service/user_service.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final authService = AuthService();
  final userService = UserService();
  final AppController controller = Modular.get<AppController>();
  void _logout() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) => const CustomAlertDialog(
        title: "Xác nhận",
        description: "Bạn có chắc chắn muốn đăng xuất?",
        confirmText: "Đăng xuất",
        cancelText: "Huỷ",
      ),
    );
    if (result == true) {
      await authService.signOut();
      if (mounted) {
        Modular.to.navigate("/authen");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        title: const TextHead(text: 'Profile'),
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Gap.mL, vertical: Gap.mL),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: Gap.sM),
              StreamBuilder<Users?>(
                stream: userService.streamUser,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError || snapshot.data == null) {
                    return Center(
                        child: Text(
                            "Error: ${snapshot.error ?? "Failed to load profile"}"));
                  }
                  final userProfile = snapshot.data!;
                  final role = userProfile.role;
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: (userProfile.imageurl == null ||
                                userProfile.imageurl!.isEmpty)
                            ? const AssetImage("assets/no_image.png")
                                as ImageProvider
                            : NetworkImage(userProfile.imageurl!),
                      ),

                      TextHead(
                        text: userProfile.name,
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Gap.lgHeight,
                      // Hiển thị profile cho mọi role
                      CustomProfile(user: userProfile),

                      // Nếu là admin hoặc nhân viên thì có thêm mục "Manage"
                      if (role == "admin" || role == "staff")
                        ListTile(
                          leading: const Icon(Icons.manage_accounts),
                          title: Text(
                            "Manage",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Modular.to.pushNamed("/manage/");
                          },
                        ),
                      Gap.lgHeight,
                      SwitchListTile(
                        title: controller.isDarkMode
                            ? const Text("Light mode")
                            : const Text("Dark mode"),
                        value: controller.isDarkMode,
                        secondary: Icon(
                          controller.isDarkMode
                              ? Icons.light_mode
                              : Icons.dark_mode,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        onChanged: (val) {
                          controller.toggleTheme();
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 80),
              SizedBox(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AppButton(text: "Logout", onPressed: _logout),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
