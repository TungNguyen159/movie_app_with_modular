import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/text_head.dart';
import 'package:movie_app/config/api_link.dart';
import 'package:movie_app/core/image/image_app.dart';

class CastAndCrew extends StatelessWidget {
  const CastAndCrew({
    super.key,
    required this.cast,
  });
  final List<dynamic> cast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextHead(text: 'Cast'),
          const SizedBox(height: 20),
          cast.isNotEmpty
              ? SizedBox(
                  height: 180,
                  child: ListView.builder(
                    itemCount: cast.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 20),
                        width: 90,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: cast[index]
                                      .profilePath
                                      .isNotEmpty
                                  ? NetworkImage(
                                      '${ApiLink.imagePath}${cast[index].profilePath}')
                                  : AssetImage(ImageApp.defaultImage),
                            ),
                            const SizedBox(height: 10),
                            Text(cast[index].originalName ?? "Unknown",
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleMedium!)
                          ],
                        ),
                      );
                    },
                  ),
                )
              : const Center(
                  child: Text(
                    "No cast available",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
