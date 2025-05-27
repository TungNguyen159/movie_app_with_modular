import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app2/detail.dart';
import 'package:movie_app2/models/movies.dart';

class CustomDetail extends StatelessWidget {
  const CustomDetail({super.key, required this.movie});
  final Movies movie;
  @override
  Widget build(BuildContext context) {
    final data = movie;
    final datetext =
        DateFormat('dd/MM/yyyy').format(DateTime.parse(data.releasedate));
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(data.posterurl),
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
                                text: data.title,
                                maxLines: 2,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Gap.xsHeight,
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      width: 1.0,
                                      style: BorderStyle.solid),
                                  borderRadius: radius8,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(Gap.sm),
                                  child: TextHead(
                                    text: 'Release Date $datetext',
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
                              text: '${data.average}',
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
                        Gap.smWidth,
                        Row(
                          children: [
                            TextHead(
                              text: '${data.duration}',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                            ),
                            const Icon(
                              Icons.timelapse,
                              color: Colors.orange,
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
                            _buildTag(data.genres!.name),
                        ],
                      ),
                    ),
                    Gap.smHeight,
                    Column(
                      children: [
                        Text(
                          data.description,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
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
