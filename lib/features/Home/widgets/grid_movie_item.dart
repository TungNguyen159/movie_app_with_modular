import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/Components/text_head.dart';
import 'package:movie_app2/core/theme/gap.dart';
import 'package:movie_app2/core/theme/radius.dart';
import 'package:movie_app2/models/movies.dart';


class GridMovieItem extends StatelessWidget {
  const GridMovieItem({
    super.key,
    required this.movies,
  });
  final Movies movies;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Gap.xs, vertical: Gap.xs),
      child: InkWell(
        onTap: () {
          Modular.to.pushNamed("/main/detail/${movies.movieid}");
        },
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              foregroundDecoration: BoxDecoration(
                borderRadius: radius20,
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: radius20,
                image: DecorationImage(
                  image:
                        NetworkImage(movies.posterurl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 15,
              right: 15,
              bottom: 15,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextHead(
                          text: movies.title,
                          maxLines: 1,
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onTertiary,
                              ),
                        ),
                        Gap.xsWidth,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextHead(
                                text: movies.average.toString(),
                                maxLines: 1,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary,
                                    )),
                            Gap.xsWidth,
                            const Icon(
                              Icons.star,
                              size: 15,
                              color: Colors.yellow,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
