
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/watchlist_controller.dart';
import '../../shared/theme.dart';
import '../../shared/values.dart';
import '../widgets/card_custom.dart';

class WatchlistPage extends StatefulWidget {

  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  final watchlistStateController = Get.put(WacthlistController());

  @override
  void initState() {
    super.initState();
    watchlistStateController.fecthMovieWacthlist();
    watchlistStateController.fecthTvWatchlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){},

          child: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),
        title: const Text('Watchlist'),
      ),

      body: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  // Tab Bar
                  TabBar(
                    tabs: [
                      // Movies
                      Tab(
                        child: Text(
                          'Movies',
                          style: blackTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: semiBold
                          ),
                        ),
                      ),

                      // Tv Shows
                      Tab(
                        child: Text(
                          'TV Shows',
                          style: blackTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: semiBold
                          ),
                        ),
                      ),
                    ],
                    dividerColor: purpleColor,
                    indicatorColor: purpleColor,
                  ),

                  // All Movie
                  Expanded(
                    child: TabBarView(
                      children: [
                        movieTabView(),
                        tvTabView(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget movieTabView() {
    return GetX(
      init: watchlistStateController,
      builder: (controller) {
        final isLoading = controller.isMovieLoading.value;
        final movies = controller.watchlistMovieResponse;

        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (movies != null && movies.isNotEmpty) {
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            itemCount: movies.length,

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.7,
            ),

            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed('/detail', arguments: movies[index].id.toString());
                },
                child: AllMovieCardCustom(
                  movieRating: movies[index].voteAverage!.toStringAsFixed(1),
                  movieTitle: movies[index].originalTitle.toString(),
                  moviePoster: apiPosterUrl + movies[index].posterPath.toString(),
                ),
              );
            },
          );
        }

        return const Center(child: Text('No Watchlist Data'));
      },
    );
  }

  Widget tvTabView() {
    return GetX(
      init: watchlistStateController,
      builder: (controller) {
        final isLoading = controller.isTvLoading.value;
        final tvShow = controller.watchlistTvResponse;

        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (tvShow != null && tvShow.isNotEmpty) {
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            itemCount: tvShow.length,

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.7,
            ),

            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed('/tv_detail', arguments: tvShow[index].id.toString());
                },
                child: AllMovieCardCustom(
                  movieRating: tvShow[index].voteAverage!.toStringAsFixed(1),
                  movieTitle: tvShow[index].originalName.toString(),
                  moviePoster: apiPosterUrl + tvShow[index].posterPath.toString(),
                ),
              );
            },
          );
        }

        return const Center(child: Text('No Watchlist Data'));
      },
    );
  }
}
