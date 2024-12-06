import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/config/api_link.dart';


class GridMovieItem extends StatelessWidget {
  const GridMovieItem({super.key, required this.snapshot, });
  final AsyncSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GridView.builder(
         gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Modular.to.pushNamed("/detail/${snapshot.data[index].id}");
            },
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  foregroundDecoration: BoxDecoration(
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
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(
                          "${keyLink.imagePath}${snapshot.data[index].posterPath}"),
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
                            Text(
                              snapshot.data[index].originalTitle,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data[index].voteAverage.toString(),
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(width: 5),
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
          );
        },
      ),
    );
  }
}
