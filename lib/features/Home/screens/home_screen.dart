import 'package:flutter/material.dart';
import 'package:movie_app/home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///list movies
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Gap.mL, vertical: Gap.mL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeHeader(),
                  Gap.mdHeight,
                  SizedBox(
                    child: ListDisplay(
                      listFuture: homeController.popularMovie,
                      builder: (snapshot) =>
                          CustomCardThumbnail(snapshot: snapshot),
                    ),
                  ),
                  Gap.mdHeight,
                  const TextHead(text: 'Top rated'),
                  SizedBox(
                    child: ListDisplay(
                      listFuture: homeController.topRatedMovie,
                      builder: (snapshot) =>
                          CustomCardMovie(snapshot: snapshot),
                    ),
                  ),
                  Gap.mdHeight,
                  const TextHead(text: "Now playing"),
                  SizedBox(
                    child: ListDisplay(
                      listFuture: homeController.nowPlaying,
                      builder: (snapshot) =>
                          CustomCardMovie(snapshot: snapshot),
                    ),
                  ),
                  Gap.mdHeight,
                  const TextHead(text: "Upcoming"),
                  SizedBox(
                    child: ListDisplay(
                      listFuture: homeController.upComingMovie,
                      builder: (snapshot) =>
                          CustomCardMovie(snapshot: snapshot),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Modular.to.navigate("/home/seeAll");
                      },
                      child: const Text("See all"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
