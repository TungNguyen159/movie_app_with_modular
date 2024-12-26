import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Hi Jack!',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: () {
            Modular.to.navigate("/authen/");
          },
          child: const CircleAvatar(
            radius: 26,
            backgroundImage: NetworkImage(
              'https://static.vecteezy.com/system/resources/thumbnails/007/209/020/small_2x/close-up-shot-of-happy-dark-skinned-afro-american-woman-laughs-positively-being-in-good-mood-dressed-in-black-casual-clothes-isolated-on-grey-background-human-emotions-and-feeligs-concept-photo.jpg',
            ),
          ),
        ),
      ],
    );
  }
}
