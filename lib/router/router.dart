import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/features/Favorites/favorite.dart';
import 'package:movie_app/features/Home/Home_page.dart';
import 'package:movie_app/features/Search/Search_screen.dart';
import 'package:movie_app/features/Settings/settings.dart';
import 'package:movie_app/features/details/detail_screen.dart';
import 'package:movie_app/router/bottom_bar.dart';

class AppNavigation {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHomeKey =
      GlobalKey<NavigatorState>(debugLabel: "/home");
  static final _shellNavigatorSearchKey =
      GlobalKey<NavigatorState>(debugLabel: "/search");
  static final _shellNavigatorFavoriteKey =
      GlobalKey<NavigatorState>(debugLabel: "/favorite");
  static final _shellNavigatorSettingKey =
      GlobalKey<NavigatorState>(debugLabel: "/setting");
  final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: "/home",
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state, navigationShell) {
            return BottomBar(
              navigationShell: navigationShell,
            );
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: _shellNavigatorHomeKey,
              routes: [
                GoRoute(
                  name: "/home",
                  path: "/home",
                  builder: (context, state) {
                    return const HomePage();
                  },
                  routes: [
                    GoRoute(
                        name: "/detail",
                        path: "/detail/:movieId",
                        builder: (context, state) {
                          final movieId =
                              int.parse(state.pathParameters['movieId']!);
                          return DetailScreen(movieId: movieId);
                        }),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorFavoriteKey,
              routes: [
                GoRoute(
                    name: "/favorite",
                    path: "/favorite",
                    builder: (context, state) {
                      return const FavoriteScreen();
                    }),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorSearchKey,
              routes: [
                GoRoute(
                  name: "/search",
                  path: "/search",
                  builder: (context, state) {
                    return const SearchScreen();
                  },
                  routes: [
                    GoRoute(
                        name: "/searchDetails",
                        path: "/searchDetails/:movieIds",
                        builder: (context, state) {
                          final movieId =
                              int.parse(state.pathParameters['movieIds']!);
                          return DetailScreen(movieId: movieId);
                        }),
                  ],
                ),
              ],
            ),

            StatefulShellBranch(
              navigatorKey: _shellNavigatorSettingKey,
              routes: [
                GoRoute(
                    name: "/setting",
                    path: "/setting",
                    builder: (context, state) {
                      return const SettingScreen();
                    }),
              ],
            ),
          ]),
      // GoRoute(
      //     name: "/detail",
      //     path: "/detail/:movieId",
      //     builder: (context, state) {
      //       final movieId = int.parse(state.pathParameters['movieId']!);
      //       return DetailScreen(movieId: movieId);
      //     }),
    ],
  );
}
