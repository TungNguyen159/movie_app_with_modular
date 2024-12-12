import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/app_elevated_button.dart';
import 'package:movie_app/Widgets/text_head.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextHead(text: 'Profile'),
        backgroundColor: const Color.fromARGB(255, 2, 35, 62),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://static.vecteezy.com/system/resources/thumbnails/007/209/020/small_2x/close-up-shot-of-happy-dark-skinned-afro-american-woman-laughs-positively-being-in-good-mood-dressed-in-black-casual-clothes-isolated-on-grey-background-human-emotions-and-feeligs-concept-photo.jpg"),
                  radius: 70,
                ),
              ),
            ),
          ),
          const Text(
            "username",
            style: TextStyle(fontSize: 20,color: Colors.white),
          ),
          const SizedBox(height: 10),
          const AppElevatedButton(text: "Edit profile"),
          const SizedBox(height: 10),
          menuSetting(),
          menuSetting(),
          menuSetting(),
          menuSetting(),
          menuSetting(),
        ],
      ),
    );
  }

  Padding menuSetting() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue.withOpacity(0.5)),
          child: const Icon(
            Icons.settings,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        trailing: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.withOpacity(0.5),
          ),
          child: const Icon(
            Icons.arrow_right,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
