import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/text_head.dart';
import 'package:movie_app/config/api_link.dart';
import 'package:movie_app/core/image/image_app.dart';
import 'package:movie_app/core/theme/gap.dart';
import 'package:movie_app/core/theme/radius.dart';

class CustomDetail extends StatelessWidget {
  const CustomDetail({super.key, required this.snapshot});
  final AsyncSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // foregroundDecoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     colors: [
                //       Colors.black.withOpacity(0.8),
                //       Colors.transparent,
                //     ],
                //     begin: Alignment.bottomCenter,
                //     end: Alignment.topCenter,
                //   ),
                // ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: snapshot.data.posterPath.isNotEmpty
                        ? NetworkImage(
                            '${ApiLink.imagePath}${snapshot.data.posterPath}')
                        : AssetImage(ImageApp.defaultImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Gap.smHeight,
              Container(
                margin: const EdgeInsets.symmetric(horizontal: Gap.mL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextHead(
                                text: '${snapshot.data.originalTitle}',
                                maxLines: 2,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Gap.xsHeight,
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                      width: 1.0,
                                      style: BorderStyle.solid),
                                  borderRadius: radius8,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(Gap.sm),
                                  child: TextHead(
                                    text:
                                        'Release Date ${snapshot.data.releaseDate}',
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            TextHead(
                              text: '${snapshot.data.voteAverage}',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            )
                          ],
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var genres in snapshot.data.genres)
                            _buildTag('${genres.name}'),
                        ],
                      ),
                    ),
                    Gap.smHeight,
                    Column(
                      children: [
                        Text(
                          '${snapshot.data.overview}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String title) {
    return Container(
      margin: const EdgeInsets.only(top: Gap.mL, right: Gap.xs),
      padding: const EdgeInsets.symmetric(
        vertical: Gap.sm,
        horizontal: Gap.mL,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 117, 91, 121),
        borderRadius: radius20,
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}
