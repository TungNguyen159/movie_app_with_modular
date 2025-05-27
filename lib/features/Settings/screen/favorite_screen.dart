import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/Components/back_button.dart';
import 'package:movie_app2/features/Settings/widgets/favorite_list_item.dart';
import 'package:movie_app2/service/favorite_service.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteService = FavoriteService();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite"),
        leading: BackBind(
          onPressed: () {
            Modular.to.pop();
          },
        ),
      ),
      body: StreamBuilder(
        stream: favoriteService.streamfavorites,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text("không có dữ liệu"));
          }
          final favor = snapshot.data!;
          if (favor.isEmpty) {
            return const Center(child: Text("Chưa có yêu thích"));
          }
          return Favoritelistitem(favor: favor);
        },
      ),
    );
  }
}
