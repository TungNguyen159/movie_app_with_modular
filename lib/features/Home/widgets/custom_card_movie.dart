import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/Components/text_head.dart';
import 'package:movie_app2/core/theme/gap.dart';
import 'package:movie_app2/core/theme/radius.dart';
import 'package:movie_app2/models/movies.dart';

class CustomCardMovie extends StatelessWidget {
  const CustomCardMovie({
    super.key,
    required this.snapshot,
  });

  final List<Movies> snapshot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Gap.sM, vertical: Gap.sM),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Số cột
          crossAxisSpacing: Gap.sM , // Giảm khoảng cách ngang
          mainAxisSpacing: Gap.sM , // Giảm khoảng cách dọc
          childAspectRatio: 0.6, // Điều chỉnh tỉ lệ item
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          final data = snapshot[index];
          return InkWell(
            onTap: () {
              Modular.to.pushNamed("/main/detail/${data.movieid}");
            },
            child: ClipRRect(
              borderRadius: radius20,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: radius20,
                      image: DecorationImage(
                        image: NetworkImage(data.posterurl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
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
                  ),
                  Positioned(
                    left: 10,
                    right: 10,
                    bottom: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextHead(
                          text: data.title,
                          maxLines: 1,
                          textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Colors.white,
                              ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            TextHead(
                              text: data.average.toString(),
                              maxLines: 1,
                              textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.star,
                              size: 15,
                              color: Colors.yellow,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}