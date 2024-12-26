import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/config/api_link.dart';
import 'package:movie_app/core/theme/radius.dart';

class CustomCardThumbnail extends StatelessWidget {
  const CustomCardThumbnail({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: 10,
        itemBuilder: (context, index, pageViewIndex) {
          return InkWell(
            onTap: () {
              Modular.to.pushNamed("/main/detail/${snapshot.data[index].id}");
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: radius20,
                  image: DecorationImage(
                      image: NetworkImage(
                          "${ApiLink.imagePath}${snapshot.data[index].posterPath}"),
                      fit: BoxFit.cover)),
              margin: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 20,
                bottom: 20,
              ),
            ),
          );
        },
        options: CarouselOptions(
          height: 400,
          autoPlay: true,
          viewportFraction: 0.7,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 2),
        ),
      ),
    );
  }
}
