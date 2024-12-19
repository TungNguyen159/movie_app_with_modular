
import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/text_head.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

class VideosList extends StatelessWidget {
  const VideosList({super.key, required this.snapshot});
  final AsyncSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    // Kiểm tra dữ liệu trước khi render
    if (!snapshot.hasData || snapshot.data.isEmpty) {
      return const Center(
        child: Text(
          "Không có video để hiển thị",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    void openWebPage(String url) async {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextHead(text: "Trailer"),
          const SizedBox(height: 10),
          SizedBox(
            height: 200, // Đặt chiều cao cụ thể cho ListView.builder
            child: ListView.builder(
              itemCount: snapshot.data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                final video = snapshot.data[index];
                final videoId = video['key']; // Lấy videoId từ API
                final videoUrl = 'https://www.youtube.com/watch?v=$videoId';
                return GestureDetector(
                  onTap: () => openWebPage(videoUrl),
                  // onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => VimeoPlayer(videoId: videoId),
                  //     ),
                  //   );
                  // },
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade800,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.play_circle_fill,
                          size: 50,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          video['name'] ?? "Tên video",
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
