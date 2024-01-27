

import 'package:filmku/controllers/all_movie_controller.dart';
import 'package:filmku/models/movie/poster_movie_model.dart';
import 'package:filmku/shared/theme.dart';
import 'package:filmku/shared/values.dart';
import 'package:filmku/ui/widgets/card_custom.dart';
import 'package:filmku/ui/widgets/input_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/main_navigation_controller.dart';

class AllMoviePage extends StatefulWidget {
  const AllMoviePage({Key? key}) : super(key: key);

  @override
  State<AllMoviePage> createState() => _AllMoviePageState();
}

class _AllMoviePageState extends State<AllMoviePage> {
  final navigationStateController = Get.put(MainNavigationController());
  final allMovieStateController = Get.put(AllMovieController());
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    allMovieStateController.fetchNowPlayingData();
    allMovieStateController.fetchPopularData();
    allMovieStateController.fetcTopRatedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        leading: GestureDetector(
          onTap: (){
              navigationStateController.indexPage = 0;
            },

          child: Icon(Icons.arrow_back_rounded),
        ),
      ),

      body: PopScope(
        canPop: false,
        onPopInvoked: (didpop){
          if(didpop){
            return;
          }

          navigationStateController.indexPage = 0;
        },
        child: Column(
          children: [
            // Search Movie
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: SearchBarCustom(
                hintText: 'Search Movie',
                controller: searchController,
                onFieldSubmitted: (value){
                  if(value.isEmpty){
                    allMovieStateController.isSearching(false);
                  } else {
                    allMovieStateController.isSearching(true);
                    allMovieStateController.searchMovie(value);
                  }

                  setState(() {});
                },
              ),
            ),

            GetX(
                init: allMovieStateController,
                builder: (controller){
                  final searchMovie = controller.searchMovieResponse;
                  final isLoading = controller.searchLoading.value;
                  final isSearching = controller.isSearching.value;

                  if(isLoading){
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Search View
                  if(isSearching == true && searchMovie != null){
                    return searchResultView(searchMovie);

                  // Tab View
                  } else {
                    return Expanded(
                      child: DefaultTabController(
                        length: 3,
                        child: Column(
                          children: [
                            // Tab Bar
                            TabBar(
                              tabs: [
                                // Now Playing Movie
                                Tab(
                                  child: Text(
                                    'Now Playing',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: semiBold
                                    ),
                                  ),
                                ),

                                // Popular Movie
                                Tab(
                                  child: Text(
                                    'Popular',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: semiBold
                                    ),
                                  ),
                                ),

                                // Top Rated Movie
                                Tab(
                                  child: Text(
                                    'Top Rated',
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
                                  nowPlayingTabView(),
                                  popularTabView(),
                                  topRatedTabView(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget searchResultView(List<PosterMovieModel> searchMovie){
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        itemCount: searchMovie.length,

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.7,
        ),

        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed('/detail', arguments: searchMovie[index].id.toString());
            },
            child: AllMovieCardCustom(
              movieRating: searchMovie[index].voteAverage!.toStringAsFixed(1),
              movieTitle: searchMovie[index].originalTitle.toString(),
              moviePoster: apiPosterUrl + searchMovie[index].posterPath.toString(),
            ),
          );
        },
      ),
    );
  }
  
  Widget nowPlayingTabView() {
    return GetX(
      init: allMovieStateController,
      builder: (controller) {
        final isLoading = controller.isNowPlayingLoading.value;
        final movies = controller.nowPlayingMovieResponse;

        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (movies != null) {
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

        return const Center(child: Text('Something Went Wrong :('));
      },
    );
  }

  Widget popularTabView() {
    return GetX(
      init: allMovieStateController,
      builder: (controller) {
        final isLoading = controller.isPopularLoading.value;
        final movies = controller.popularMovieResponse;

        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (movies != null) {
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

        return const Center(child: Text('Something Went Wrong :('));
      },
    );
  }

  Widget topRatedTabView() {
    return GetX(
      init: allMovieStateController,
      builder: (controller) {
        final isLoading = controller.isTopRatedLoading.value;
        final movies = controller.topRatedMovieResponse;

        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (movies != null) {
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

        return const Center(child: Text('Something Went Wrong :('));
      },
    );
  }
}
