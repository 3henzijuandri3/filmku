import 'package:filmku/shared/theme.dart';
import 'package:filmku/ui/pages/all_movie_page.dart';
import 'package:filmku/ui/pages/all_tv_page.dart';
import 'package:filmku/ui/pages/movie_detail_page.dart';
import 'package:filmku/ui/pages/home_page.dart';
import 'package:filmku/ui/pages/navigation_page.dart';
import 'package:filmku/ui/pages/profile_page.dart';
import 'package:filmku/ui/pages/rated_page.dart';
import 'package:filmku/ui/pages/tmdb_web_page.dart';
import 'package:filmku/ui/pages/tv_detail_page.dart';
import 'package:filmku/ui/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'filmku',
      debugShowCheckedModeBanner: false ,

      theme: ThemeData(
          scaffoldBackgroundColor: lightBackgroundColor,
          useMaterial3: false,
          appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
            backgroundColor: lightBackgroundColor,

            iconTheme: IconThemeData(
              color: blackColor,
            ),

            titleTextStyle: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold
            ),
          ),
      ),

      getPages: [
        GetPage(name: '/', page: () => NavigationPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/all_movie', page: () => const AllMoviePage()),
        GetPage(name: '/all_tv', page: () => const AllTvPage()),
        GetPage(name: '/profile', page: () => ProfilePage()),
        GetPage(name: '/watchlist', page: () => WatchlistPage()),
        GetPage(name: '/rated', page: () => RatedPage()),
        GetPage(name: '/tmdb_web', page: () => TmdbWebPage(requestToken: Get.arguments)),
        GetPage(name: '/detail', page: () => MovieDetailPage(movieId: Get.arguments)),
        GetPage(name: '/tv_detail', page: () => TvDetailPage(tvid: Get.arguments)),
      ],
    );
  }
}