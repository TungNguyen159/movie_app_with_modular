
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

  
  // Column date() {
  //   return Column(
  //     children: [
  //       TextHead(
  //         text: "select a date",
  //       ),
  //       const SizedBox(height: 10),
  //       Container(
  //         height: 150,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(20),
  //           color: Colors.grey.withOpacity(0.2),
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             Container(
  //                 height: 100,
  //                 decoration: BoxDecoration(
  //                   border: Border.all(
  //                       color: Colors.white,
  //                       width: 1.0,
  //                       style: BorderStyle.solid),
  //                   borderRadius: const BorderRadius.all(
  //                     Radius.circular(10),
  //                   ), //
  //                 ),
  //                 child: const Padding(
  //                   padding: EdgeInsets.all(8.0),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       TextHead(text: "monday"),
  //                       TextHead(text: "18"),
  //                     ],
  //                   ),
  //                 )),
  //             Container(
  //                 height: 100,
  //                 decoration: BoxDecoration(
  //                   border: Border.all(
  //                       color: Colors.white,
  //                       width: 1.0,
  //                       style: BorderStyle.solid),
  //                   borderRadius: const BorderRadius.all(
  //                     Radius.circular(10),
  //                   ), //
  //                 ),
  //                 child: const Padding(
  //                   padding: EdgeInsets.all(8.0),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       TextHead(text: "monday"),
  //                       TextHead(text: "18"),
  //                     ],
  //                   ),
  //                 )),
  //             Container(
  //                 height: 100,
  //                 decoration: BoxDecoration(
  //                   border: Border.all(
  //                       color: Colors.white,
  //                       width: 1.0,
  //                       style: BorderStyle.solid),
  //                   borderRadius: const BorderRadius.all(
  //                     Radius.circular(10),
  //                   ), //
  //                 ),
  //                 child: const Padding(
  //                   padding: EdgeInsets.all(8.0),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       TextHead(text: "monday"),
  //                       TextHead(text: "18"),
  //                     ],
  //                   ),
  //                 )),
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Column room() {
  //   return Column(
  //     children: [
  //       TextHead(
  //         text: "select a cinema",
  //       ),
  //       const SizedBox(height: 10),
  //       Container(
  //         height: 100,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(20),
  //           color: Colors.grey.withOpacity(0.2),
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             Container(
  //                 decoration: BoxDecoration(
  //                   border: Border.all(
  //                       color: Colors.white,
  //                       width: 1.0,
  //                       style: BorderStyle.solid),
  //                   borderRadius: const BorderRadius.all(
  //                     Radius.circular(10),
  //                   ), //
  //                 ),
  //                 child: const Padding(
  //                   padding: EdgeInsets.all(8.0),
  //                   child: TextHead(text: "2D"),
  //                 )),
  //             Container(
  //                 decoration: BoxDecoration(
  //                   border: Border.all(
  //                       color: Colors.white,
  //                       width: 1.0,
  //                       style: BorderStyle.solid),
  //                   borderRadius: const BorderRadius.all(
  //                     Radius.circular(10),
  //                   ), //
  //                 ),
  //                 child: const Padding(
  //                   padding: EdgeInsets.all(8.0),
  //                   child: TextHead(text: "3D"),
  //                 )),
  //             Container(
  //                 decoration: BoxDecoration(
  //                   border: Border.all(
  //                       color: Colors.white,
  //                       width: 1.0,
  //                       style: BorderStyle.solid),
  //                   borderRadius: const BorderRadius.all(
  //                     Radius.circular(10),
  //                   ), //
  //                 ),
  //                 child: const Padding(
  //                   padding: EdgeInsets.all(8.0),
  //                   child: TextHead(text: "IMAX"),
  //                 )),
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  // }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class SeatScreen extends StatefulWidget {
//   const SeatScreen({super.key});

//   @override
//   State<SeatScreen> createState() => _SeatScreenState();
// }

// class _SeatScreenState extends State<SeatScreen> {
//   final int rows = 8;
//   final int columns = 6;

//   // Danh sách ghế đã chọn sẵn
//   final List<String> selectedSeatDefaults = ["A1", "B3", "C5", "D2"];

//   // Trạng thái ghế (true: đã chọn, false: chưa chọn)
//   late List<List<bool>> selectedSeats;

//   @override
//   void initState() {
//     super.initState();
//     // Khởi tạo danh sách ghế với giá trị mặc định
//     selectedSeats = List.generate(rows, (row) {
//       return List.generate(columns, (col) {
//         String seatName = "${String.fromCharCode(65 + row)}${col + 1}";
//         return selectedSeatDefaults.contains(seatName);
//       });
//     });
//   }

//   void _toggleSeat(int row, int col) {
//     setState(() {
//       selectedSeats[row][col] = !selectedSeats[row][col]; // Đổi trạng thái ghế
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Chọn ghế ngồi"),
//         centerTitle: true,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               "Sơ đồ ghế ngồi",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(rows, (row) {
//                   return Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(columns, (col) {
//                       return GestureDetector(
//                         onTap: () => _toggleSeat(row, col),
//                         child: Container(
//                           margin: const EdgeInsets.all(4),
//                           width: 40,
//                           height: 40,
//                           decoration: BoxDecoration(
//                             color: selectedSeats[row][col] ? Colors.green : Colors.grey[300],
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Colors.black, width: 1),
//                           ),
//                           child: Center(
//                             child: Text(
//                               "${String.fromCharCode(65 + row)}${col + 1}",
//                               style: const TextStyle(fontSize: 12,color: Colors.black),
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                   );
//                 }),
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               List<String> chosenSeats = [];
//               for (int row = 0; row < rows; row++) {
//                 for (int col = 0; col < columns; col++) {
//                   if (selectedSeats[row][col]) {
//                     chosenSeats.add("${String.fromCharCode(65 + row)}${col + 1}");
//                   }
//                 }
//               }
//               // Hiển thị các ghế đã chọn
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text("Ghế đã chọn: ${chosenSeats.join(", ")}")),
//               );
//             },
//             child: const Text("Xác nhận"),
//           ),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }
