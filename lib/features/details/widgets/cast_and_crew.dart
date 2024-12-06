import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/text_head.dart';
import 'package:movie_app/config/api_link.dart';

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
        vertical: 20,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextHead(text: 'Cast'),
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 20),
                  width: 90,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(20),
                        //   image: DecorationImage(
                        //     image: NetworkImage(
                        //         '${keyLink.imagePath}${cast[index].profilePath}'),
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:  NetworkImage(
                                '${keyLink.imagePath}${cast[index].profilePath}'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        cast[index].originalName,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
