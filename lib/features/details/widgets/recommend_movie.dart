import 'package:flutter/material.dart';
import 'package:movie_app2/detail.dart';
import 'package:movie_app2/models/movies.dart';

class RecommendScreen extends StatelessWidget {
  const RecommendScreen({super.key, required this.movie});
  final List<Movies> movie;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Gap.sM, horizontal: Gap.mL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextHead(text: "Recommend movie"),
          Gap.sMHeight,
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  final movies = movie[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: Gap.md),
                    child: InkWell(
                      onTap: () {
                        Modular.to.pushNamed("/main/detail/${movies.movieid}");
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: radius20,
                            child: Container(
                              height: 150,
                              width: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(movies.posterurl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 20,
                            right: 15,
                            bottom: 5,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movies.title,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onTertiary,
                                        ),
                                      ),
                                      Gap.xsHeight
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
                },
              ))
        ],
      ),
    );
  }
}
