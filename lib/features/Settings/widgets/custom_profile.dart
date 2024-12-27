import 'package:flutter/material.dart';
import 'package:movie_app/home.dart';

class CustomProfile extends StatelessWidget {
  const CustomProfile({
    super.key,
  });

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
                      TextHead(
                        text: 'Edit profile',
                        textStyle: Theme.of(context).textTheme.bodyMedium,
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
                decoration: const BoxDecoration(
                  border: Border(
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
                      TextHead(
                        text: 'Favourites',
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
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
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                  border: Border(
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
                      TextHead(
                        text: 'Notification',
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
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
