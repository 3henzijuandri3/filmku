import 'package:filmku/controllers/detail_controller.dart';
import 'package:filmku/models/auth/account_state_model.dart';
import 'package:filmku/models/movie/detail_movie_model.dart';
import 'package:filmku/shared/theme.dart';
import 'package:filmku/shared/values.dart';
import 'package:filmku/ui/widgets/button_custom.dart';
import 'package:filmku/ui/widgets/other_component_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/watchlist_controller.dart';

class MovieDetailPage extends StatefulWidget {
  final String movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPage();
}

class _MovieDetailPage extends State<MovieDetailPage> {
  final detailStateController = Get.put(DetailController());
  final watchlistStateController = Get.put(WacthlistController());

  @override
  void initState() {
    super.initState();
    detailStateController.fetchMovieDetailData(Get.arguments as String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX(
          init: detailStateController,
          builder: (controller){
            final isLoading = controller.isLoading.value;
            final wachlistLoading = controller.watchlistLoading.value;
            final movieDetails = controller.detailMovieResponse;
            final movieStatus = controller.movieStatusResponse;

            if(isLoading){
              return const Center(child: CircularProgressIndicator());
            }

            if(movieDetails != null && movieStatus != null){
              return Stack(
                children: [
                  // Detail Content
                  ListView(
                    children: [
                      // Top Image Information Section
                      imageInformationSection(context, movieDetails),

                      const SizedBox(height: 24),

                      // Round Information Section
                      roundInformationSection(movieDetails),

                      const SizedBox(height: 26),

                      // Plot Information Section
                      mainInformationSection(movieDetails, movieStatus),
                    ],
                  ),

                  if(wachlistLoading)
                    Stack(
                      children: [
                        // Overlay
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.black.withOpacity(0.2),
                        ),

                        // Circular Bar
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                ],
              );
            }

            return const Center(child: Text('Something Went Wrong :('));
          }),
    );
  }

  Widget imageInformationSection(BuildContext context, DetailMovieModel information){
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.45,

      // Backrop Image
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(apiImgUrl+information.backdropPath.toString())
          )
      ),

      child: Stack(
        fit: StackFit.expand,
        children: [
          // Black Overlay
          Container(
            decoration:  const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black,
                  Colors.transparent
                ],
              ),
            ),
          ),

          // Information
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,

              children: [
                // Title, Tagline, & Rating
                SizedBox(
                  width: 260,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        information.title.toString(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: whiteTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: bold
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Tagline
                      Text(
                        information.tagline.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: whiteTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: regular
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Rating & Watchlist
                      IntrinsicWidth(
                        child: ratingInformation(
                            xPadding: 4,
                            yPadding: 14,
                            fontSize: 13,
                            iconSize: 18,
                            rating: information.voteAverage!.toStringAsFixed(1)
                        ),
                      ),

                    ],
                  ),
                ),

                // Poster
                Container(
                  width: 100,
                  height: 150,

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(apiPosterUrl+information.posterPath.toString()),
                      )
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget roundInformationSection(DetailMovieModel information){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(34),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Release Date
            movieInformation(
                icon: Icons.calendar_month,
                label: information.releaseDate.toString()
            ),

            // Runtime
            movieInformation(
                icon: Icons.watch_later,
                label: '${information.runtime} mins'
            ),

            // Main Genre
            movieInformation(
                icon: Icons.category,
                label: information.genre!.name.toString().split(' ')[0]
            ),
          ],
        ),
      ),
    );
  }

  Widget mainInformationSection(DetailMovieModel information, AccountStateModel status){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Story Plot',
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semiBold
            ),
          ),

          const SizedBox(height: 6),

          Text(
            information.overview.toString(),
            textAlign: TextAlign.justify,
            style: blackTextStyle.copyWith(
              fontSize: 14,
              fontWeight: regular
            ),
          ),

          const SizedBox(height: 20),

          if(status.watchlist != null)
            Center(
            child: FilledButtonCustom(
                onTap: () async {
                  if(status.watchlist == false)  {
                    bool isSuccess = await detailStateController.addMovieToWatchlist(information.id.toString());

                    if(isSuccess){
                      watchlistStateController.fecthMovieWacthlist();
                      Get.back();
                    }

                  } else {
                    bool isSuccess = await detailStateController.removeMovieFromWatchlist(information.id.toString());

                    if(isSuccess){
                      watchlistStateController.fecthMovieWacthlist();
                      Get.back();
                    }
                  }
                },
                
                width: 250,
                height: 46,
                color: status.watchlist == false ? purpleColor  : redColor,
                label: status.watchlist == false ? 'Add To Watchlist' : 'Remove From Watchlist',
                labelSize: 16
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
