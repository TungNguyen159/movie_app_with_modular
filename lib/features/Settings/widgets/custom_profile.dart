import 'package:flutter/material.dart';
import 'package:movie_app/home.dart';

class custom_profile extends StatelessWidget {
  const custom_profile({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Modular.to.pushNamed("/main/setting/editProfile");
              },
              child: Container(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  border: Border.all(color: Colors.grey),
                ),
                height: 55,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Edit profile',
                        style:
                            theme.textTheme.bodyMedium!.copyWith(fontSize: 16),
                      ),
                      const Icon(Icons.arrow_right)
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Modular.to.pushNamed("/main/setting/favorite");
              },
              child: Container(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  border: const Border(
                      right: BorderSide(color: Colors.grey),
                      left: BorderSide(color: Colors.grey),
                      bottom: BorderSide(color: Colors.grey)),
                ),
                height: 55,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Favourites',
                          style: theme.textTheme.bodyMedium!
                              .copyWith(fontSize: 16)),
                      const Icon(Icons.arrow_right)
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Modular.to.pushNamed("/main/setting/notification");
              },
              child: Container(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                  border: const Border(
                    bottom: BorderSide(color: Colors.grey),
                    right: BorderSide(color: Colors.grey),
                    left: BorderSide(color: Colors.grey),
                  ),
                ),
                height: 55,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Notification',
                          style: theme.textTheme.bodyMedium!
                              .copyWith(fontSize: 16)),
                      const Icon(Icons.arrow_right)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
