import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/texthead.dart';
import 'package:movie_app/core/config/api_link.dart';

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
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          '${keyLink.imagePath}${snapshot.data.posterPath}'),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
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
                              TextHead(text: '${snapshot.data.originalTitle}',maxLines: 2,),
                              const SizedBox(height: 5),
                              Container(
                                decoration: BoxDecoration(
                                  
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 1.0,
                                      style: BorderStyle.solid),
                                  borderRadius:const BorderRadius.all(
                                    Radius.circular(10),
                                  ), //
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextHead(
                                      text:
                                          'Release Date ${snapshot.data.releaseDate}',
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            TextHead(text: '${snapshot.data.voteAverage}'),
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var genres in snapshot.data.genres)
                          _buildTag('${genres.name}'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Text(
                          '${snapshot.data.overview}',
                          style: const TextStyle(
                            color: Colors.white70,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
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
      margin: const EdgeInsets.only(top: 20, right: 5),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 117, 91, 121),
        borderRadius: BorderRadius.circular(18),
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
