import 'package:filmku/controllers/all_tv_controller.dart';
import 'package:filmku/controllers/main_navigation_controller.dart';
import 'package:filmku/models/tv/poster_tv_model.dart';
import 'package:filmku/shared/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/theme.dart';
import '../widgets/card_custom.dart';
import '../widgets/input_custom.dart';

class AllTvPage extends StatefulWidget {
  const AllTvPage({super.key});

  @override
  State<AllTvPage> createState() => _AllTvPageState();
}

class _AllTvPageState extends State<AllTvPage> {
  final allTvStateController = Get.put(AllTvController());
  final navigationStateController = Get.put(MainNavigationController());
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    allTvStateController.fetchNowPlayingData();
    allTvStateController.fetchPopularData();
    allTvStateController.fetcTopRatedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tv Shows'),
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
            // Searchbar Tv
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: SearchBarCustom(
                hintText: 'Search Tv Shows',
                controller: searchController,
                onFieldSubmitted: (value){
                  if(value.isEmpty){
                    allTvStateController.isSearching(false);
                  } else {
                    allTvStateController.isSearching(true);
                    allTvStateController.searchTv(value);
                  }

                  setState(() {});
                },
              ),
            ),

            GetX(
                init: allTvStateController,
                builder: (controller){
                  final searchTv = controller.searchTvResponse;
                  final isLoading = controller.searchLoading.value;
                  final isSearching = controller.isSearching.value;

                  if(isLoading){
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Search View
                  if(isSearching == true && searchTv != null){
                    return searchResultView(searchTv);

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
                                // Now Playing Tv
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

  Widget searchResultView(List<PosterTvModel> searchTv){
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        itemCount: searchTv.length,

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.7,
        ),

        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed('/tv_detail', arguments: searchTv[index].id.toString());
            },
            child: AllMovieCardCustom(
              movieRating: searchTv[index].voteAverage!.toStringAsFixed(1),
              movieTitle: searchTv[index].originalName.toString(),
              moviePoster: apiPosterUrl + searchTv[index].posterPath.toString(),
            ),
          );
        },
      ),
    );
  }

  Widget nowPlayingTabView() {
    return GetX(
      init: allTvStateController,
      builder: (controller) {
        final isLoading = controller.isNowPlayingLoading.value;
        final movies = controller.nowPlayingTvResponse;

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
                  Get.toNamed('/tv_detail', arguments: movies[index].id.toString());
                },
                child: AllMovieCardCustom(
                  movieRating: movies[index].voteAverage!.toStringAsFixed(1),
                  movieTitle: movies[index].originalName.toString(),
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
      init: allTvStateController,
      builder: (controller) {
        final isLoading = controller.isPopularLoading.value;
        final movies = controller.popularTvResponse;

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
                  Get.toNamed('/tv_detail', arguments: movies[index].id.toString());
                },
                child: AllMovieCardCustom(
                  movieRating: movies[index].voteAverage!.toStringAsFixed(1),
                  movieTitle: movies[index].originalName.toString(),
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
      init: allTvStateController,
      builder: (controller) {
        final isLoading = controller.isTopRatedLoading.value;
        final movies = controller.topRatedTvResponse;

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
                  Get.toNamed('/tv_detail', arguments: movies[index].id.toString());
                },
                child: AllMovieCardCustom(
                  movieRating: movies[index].voteAverage!.toStringAsFixed(1),
                  movieTitle: movies[index].originalName.toString(),
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
