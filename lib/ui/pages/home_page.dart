import 'package:filmku/controllers/home/home_controller.dart';
import 'package:filmku/shared/theme.dart';
import 'package:filmku/shared/values.dart';
import 'package:filmku/ui/widgets/button_custom.dart';
import 'package:filmku/ui/widgets/card_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final homeStateController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Trending Movie',
              textAlign: TextAlign.center,
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
            ),

            const SizedBox(height: 10),

            // Random Movie Card Section
            randomMovieSection(),

            const SizedBox(height: 34),

            // Home Menu Button Section
            homeMenuSection(),

            const SizedBox(height: 34),

            // Popular Movie / TV Series Section
            popularSection(),

            // Top Rated Movie / TV Series Section
            topRatedSection()
          ],
        ),
      ),
    );
  }

  Widget randomMovieSection(){
    return Obx((){
      final isLoading = homeStateController.isRandomLoading.value;
      final listRandomMovie = homeStateController.randomMovieResponse;

      if(isLoading){
        return const RandomMovieLoadingCard();
      }

      if(listRandomMovie != null){
        var randomMovie = listRandomMovie.toList()..shuffle();

        return RandomMovieCard(
            movieName: randomMovie[0].originalTitle.toString(),
            movieRate: randomMovie[0].voteAverage!.toStringAsFixed(1),
            movieImg: apiImgUrl+randomMovie[0].backdropPath.toString(),
            movieLanguage: randomMovie[0].originalLanguage.toString(),

            onTap: (){
              Get.toNamed('/detail', arguments: randomMovie[0].id.toString());
            },
          );
      }

      return const Center(child: Text('Something Went Wrong :('));
    });
  }

  Widget homeMenuSection(){
    return Obx((){
      final selectedMenu = homeStateController.selectedMenu.value;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Movie Option Menu
          GestureDetector(
            onTap: (){
              if(selectedMenu != 0){
                homeStateController.selectedMenu(0);
                homeStateController.changeMenuTitle('Movies');
              }
            },

            child: MenuButtonCustom(
                menuTitle: 'Movies',
                menuIcon: Icons.videocam,
                isSelected: selectedMenu == 0 ? true : false
            ),
          ),

          // TV Series Option Menu
          GestureDetector(
            onTap: (){
              if(selectedMenu != 1){
                homeStateController.selectedMenu(1);
                homeStateController.changeMenuTitle('TV Series');
              }
            },

            child: MenuButtonCustom(
                menuTitle: 'TV Series',
                menuIcon: Icons.tv,
                isSelected: selectedMenu == 1 ? true : false
            ),
          ),
        ],
      );
    });
  }

  // Belum
  Widget featuredSection(){
    return Obx((){
      final isLoading = homeStateController.isPopularLoading.value;
      final menuTitle = homeStateController.menuTitle.value;
      final currentMenu = homeStateController.selectedMenu.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured $menuTitle',
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semiBold,
            ),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              // Movie / Tv Image
              Container(
                width: 80,
                height: 80,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      image: AssetImage(bgOnboarding)
                  )
                ),
              ),

              const SizedBox(width: 4),

              // Movie
              const Column(
                children: [

                ],
              )
            ],
          )
        ],
      );
    });
  }

  Widget popularSection() {
    return Obx(() {
      final isLoading = homeStateController.isPopularLoading.value;
      final menuTitle = homeStateController.menuTitle.value;
      final currentMenu = homeStateController.selectedMenu.value;

      final listPopularMovie = homeStateController.popularMovieResponse;
      final listPopularTvSeries = homeStateController.popularTvResponse;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular $menuTitle',
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semiBold,
            ),
          ),

          const SizedBox(height: 14),

          if (isLoading)
            const Center(child: CircularProgressIndicator())

          else if (listPopularMovie != null && listPopularTvSeries != null)
            SizedBox(
              height: 230,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 15,

                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      if(currentMenu == 0){
                        Get.toNamed('/detail', arguments: listPopularMovie[index].id.toString());
                      } else {
                        Get.toNamed('/tv_detail', arguments: listPopularTvSeries[index].id.toString());
                      }
                    },

                    child: HomeMovieCard(
                      movieTitle: currentMenu == 0
                          ? listPopularMovie[index].originalTitle.toString()
                          : listPopularTvSeries[index].originalName.toString(),

                      moviePoster: currentMenu == 0
                          ? apiPosterUrl + listPopularMovie[index].posterPath.toString()
                          : apiPosterUrl + listPopularTvSeries[index].posterPath.toString(),

                      movieRate: currentMenu == 0
                          ? listPopularMovie[index].voteAverage!.toStringAsFixed(1)
                          : listPopularTvSeries[index].voteAverage!.toStringAsFixed(1),
                    ),
                  );
                },
              ),
            )

          else
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Center(child: Text('Something Went Wrong :(')),
              ],
            ),
        ],
      );
    });
  }

  Widget topRatedSection(){
    return Obx((){
      final isLoading = homeStateController.isPopularLoading.value;
      final menuTitle = homeStateController.menuTitle.value;
      final currentMenu = homeStateController.selectedMenu.value;

      final listTopRatedMovie = homeStateController.topRatedMovieResponse;
      final listTopRatedTvSeries = homeStateController.topRatedTvResponse;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Rated $menuTitle',
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 14),

          if (isLoading)
            const Center(child: CircularProgressIndicator())

          else if (listTopRatedMovie != null && listTopRatedTvSeries != null)
            SizedBox(
              height: 230,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 15,

                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      if(currentMenu == 0){
                        Get.toNamed('/detail', arguments: listTopRatedMovie[index].id.toString());
                      } else {
                        Get.toNamed('/tv_detail', arguments: listTopRatedTvSeries[index].id.toString());
                      }
                    },

                    child: HomeMovieCard(
                      movieTitle: currentMenu == 0
                          ? listTopRatedMovie[index].originalTitle.toString()
                          : listTopRatedTvSeries[index].originalName.toString(),
                      moviePoster: currentMenu == 0
                          ? apiPosterUrl +
                          listTopRatedMovie[index].posterPath.toString()
                          : apiPosterUrl +
                          listTopRatedTvSeries[index].posterPath.toString(),
                      movieRate: currentMenu == 0
                          ? listTopRatedMovie[index].voteAverage!
                          .toStringAsFixed(1)
                          : listTopRatedTvSeries[index].voteAverage!
                          .toStringAsFixed(1),
                    ),
                  );
                },
              ),
            )

          else
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Center(child: Text('Something Went Wrong :(')),
              ],
            ),
        ],
      );
    });
  }
}
