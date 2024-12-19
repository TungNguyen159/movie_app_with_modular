import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/app_elevated_button.dart';
import 'package:movie_app/core/theme/theme.dart';
import 'package:movie_app/features/Settings/widgets/custom_profile.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isSwitched = false;
  bool isSwitched2 = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
          scrolledUnderElevation: 0,
          elevation: 0,
          title: Text(
            'Profile',
            style: theme.textTheme.bodyLarge!.copyWith(fontSize: 22),
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://static.vecteezy.com/system/resources/thumbnails/007/209/020/small_2x/close-up-shot-of-happy-dark-skinned-afro-american-woman-laughs-positively-being-in-good-mood-dressed-in-black-casual-clothes-isolated-on-grey-background-human-emotions-and-feeligs-concept-photo.jpg"),
                      radius: 70,
                    ),
                    Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 14),
                        height: 30,
                        width: 300,
                        child: Text(
                          'Victor Nsenji',
                          style:
                              theme.textTheme.bodyLarge!.copyWith(fontSize: 17),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                custom_profile(theme: theme),
                const SizedBox(height: 29),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Settings',
                      style: theme.textTheme.bodyLarge!.copyWith(fontSize: 17),
                    )),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.palette_outlined),
                                const SizedBox(width: 10),
                                Text(
                                  'Theme',
                                  style: theme.textTheme.bodyMedium!
                                      .copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                            Transform.scale(
                              scale: 0.7,
                              child: Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.notifications_none),
                                const SizedBox(width: 10),
                                Text('Push Notification',
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(fontSize: 16)),
                              ],
                            ),
                            Transform.scale(
                              scale: 0.7,
                              child: Switch(
                                value: isSwitched2,
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             AppElevatedButton(text: "logout",bgColor: Colors.grey,)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
