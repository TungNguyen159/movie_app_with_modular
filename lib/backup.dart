
  // Widget _indicator(bool isActive) {
  //   return AnimatedContainer(
  //     duration: Duration(milliseconds: 2000),
  //     margin: const EdgeInsets.symmetric(horizontal: 5.0),
  //     height: 5.0,
  //     width: 5.0,
  //     decoration: BoxDecoration(
  //       color: isActive ? Colors.white : Colors.grey,
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //   );
  // }

  // child: PageView.builder(
  //   controller: pageController,
  //   itemCount: movieList.length,
  //   itemBuilder: (context, index) {
  //     return CustomCardThumnail(
  //       imageAsset: movieList[index].imageAsset.toString(),
  //     );
  //   },
  //   onPageChanged: (int page) {
  //     setState(() {
  //       currentPage = page;
  //     });
  //   },
  // ),

  // Widget _movieList(List<MovieModel> movieLists) {
  //   return
  // }

  // Widget _genresList(List<MovieModel> genresList) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
  //     height: MediaQuery.of(context).size.height * 0.20,
  //     child: ListView.builder(
  //       shrinkWrap: true,
  //       scrollDirection: Axis.horizontal,
  //       itemCount: genresList.length,
  //       itemBuilder: (context, index) {
  //         return CustomGenres(
  //           movieModel: genresList[index],
  //         );
  //       },
  //     ),
  //   );
  // }

  // Widget _legendaryList(List<MovieModel> legendList) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
  //     height: MediaQuery.of(context).size.height * 0.25,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: genresList.length,
  //       itemBuilder: (context, index) {
  //         return CustomCardMovie(
  //           movieModel: legendList[index],
  //         );
  //       },
  //     ),
  //   );
  // }