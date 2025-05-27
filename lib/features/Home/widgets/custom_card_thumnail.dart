import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/core/theme/radius.dart';
import 'package:movie_app2/models/movies.dart';

class CustomCardThumbnail extends StatelessWidget {
  const CustomCardThumbnail({
    super.key,
    required this.snapshot,
  });
  final List<Movies> snapshot;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: 5,
        itemBuilder: (context, index, pageViewIndex) {
          final data = snapshot[index];
          return InkWell(
            onTap: () {
              Modular.to.pushNamed("/main/detail/${data.movieid}");
            },
            child: AspectRatio(
              aspectRatio: 2 / 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: radius20,
                  image: DecorationImage(
                    image:
                        NetworkImage(data.posterurl),
                    fit: BoxFit.cover,
                  ),
                ),
                margin: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 20,
                  bottom: 20,
                ),
              ),
            ),
          );
        },
        options: CarouselOptions(
          height: 400,
          autoPlay: true,
          viewportFraction: 0.6,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 2),
        ),
      ),
    );
  }
}
