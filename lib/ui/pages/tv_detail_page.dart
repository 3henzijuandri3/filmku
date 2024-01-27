
import 'package:filmku/controllers/detail_controller.dart';
import 'package:filmku/models/auth/account_state_model.dart';
import 'package:filmku/models/tv/detail_tv_model.dart';
import 'package:filmku/shared/theme.dart';
import 'package:filmku/shared/values.dart';
import 'package:filmku/ui/widgets/other_component_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/watchlist_controller.dart';
import '../widgets/button_custom.dart';

class TvDetailPage extends StatefulWidget {
  final String tvid;

  const TvDetailPage({super.key, required this.tvid});

  @override
  State<TvDetailPage> createState() => _TvDetailPage();
}

class _TvDetailPage extends State<TvDetailPage> {
  final detailStateController = Get.put(DetailController());
  final watchlistStateController = Get.put(WacthlistController());

  @override
  void initState() {
    super.initState();
    detailStateController.fetchTvDetailData(Get.arguments as String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX(
          init: detailStateController,
          builder: (controller){
            final isLoading = controller.isLoading.value;
            final wachlistLoading = controller.watchlistLoading.value;
            final tvDetails = controller.detailTvResponse;
            final tvStatus = controller.tvStatusResponse;

            if(isLoading){
              return const Center(child: CircularProgressIndicator());
            }

            if(tvDetails != null && tvStatus != null){
              return Stack(
                children: [
                  // Detail Content
                  ListView(
                    children: [
                      // Top Image Information Section
                      imageInformationSection(context, tvDetails),

                      const SizedBox(height: 24),

                      // Round Information Section
                      roundInformationSection(tvDetails),

                      const SizedBox(height: 26),

                      // Plot Information Section
                      mainInformationSection(tvDetails, tvStatus),
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

  Widget imageInformationSection(BuildContext context, TvDetailModel information){
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
                        information.name.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: whiteTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: bold
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Runtime
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Icon
                          Icon(Icons.watch_later_outlined, color: whiteColor, size: 20),

                          const SizedBox(width: 8),

                          // Runtime Text
                          Text(
                            information.episodeRunTime?.isNotEmpty == true
                                ? '${information.episodeRunTime!.first} mins'
                                : 'n/a',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: whiteTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: regular
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // Rating
                      IntrinsicWidth(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                          decoration: BoxDecoration(
                            color: greyColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15),
                          ),

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              // Star Icon
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 18,
                              ),

                              const SizedBox(width: 4),

                              // Movie Rate Score
                              Text(
                                information.voteAverage!.toStringAsFixed(1),
                                style: whiteTextStyle.copyWith(
                                    fontSize: 13,
                                    fontWeight: medium
                                ),
                              )
                            ],
                          ),
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

  Widget roundInformationSection(TvDetailModel information){
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
            // Season Count
            movieInformation(
                icon: Icons.calendar_month,
                label: '${information.numberOfSeasons} Seasons'
            ),

            // Episode Count
            movieInformation(
                icon: Icons.watch_later,
                label: '${information.numberOfEpisodes} Episode'
            ),

            // Main Genre
            movieInformation(
                icon: Icons.category,
                label: information.genre != null ? information.genre!.name.toString().split(' ')[0] : 'n/a'
            ),
          ],
        ),
      ),
    );
  }

  Widget mainInformationSection(TvDetailModel information, AccountStateModel status){
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
                    bool isSuccess = await detailStateController.addTvToWatchlist(information.id.toString());

                    if(isSuccess){
                      watchlistStateController.fecthTvWatchlist();
                      Get.back();
                    }

                  } else {
                    bool isSuccess = await detailStateController.removeTvFromWatchlist(information.id.toString());

                    if(isSuccess){
                      watchlistStateController.fecthTvWatchlist();
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
