import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/Components/text_head.dart';
import 'package:movie_app2/core/image/image_app.dart';
import 'package:movie_app2/core/theme/gap.dart';
import 'package:movie_app2/core/theme/radius.dart';
import 'package:movie_app2/models/movies.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({super.key, required this.movie});
  final List<Movies> movie;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: Gap.sM,
        ),
        width: double.infinity,
        child: ListView.builder(
          itemCount: movie.length,
          itemBuilder: (ctx, index) {
            final data = movie[index];
            return Padding(
              padding: const EdgeInsets.only(top: Gap.sM),
              child: SizedBox(
                width: double.infinity,
                child: InkWell(
                  onTap: () {
                    Modular.to.pushNamed("/main/detail/${data.movieid}");
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: Gap.sm),
                        child: Column(
                          children: [
                            Image.network(
                              data.posterurl,
                              height: 120,
                              width: 100,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  ImageApp.defaultImage,
                                  height: 120,
                                  width: 100,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextHead(
                                text: data.title,
                                maxLines: 2,
                                textStyle:
                                    Theme.of(context).textTheme.titleMedium!
                                //overflow: TextOverflow.ellipsis,
                                ),
                            Gap.xsHeight,
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    width: 1.0,
                                    style: BorderStyle.solid),
                                borderRadius: radius8,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(Gap.sm),
                                child: TextHead(
                                  text: 'Release Date ${data.releasedate}',
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.yellow,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: radius50,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(Gap.sm)
                              .copyWith(top: Gap.mL),
                          child: Text(
                           data.average.toString(),
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
