import 'package:filmku/ui/widgets/other_component_custom.dart';
import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class RandomMovieCard extends StatelessWidget {
  final String movieName;
  final String movieRate;
  final String movieImg;
  final String movieLanguage;
  final Function onTap;

  const RandomMovieCard({
    Key? key,
    required this.movieName,
    required this.movieRate,
    required this.movieImg,
    required this.movieLanguage,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 260,

        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              offset: const Offset(
                0.0,
                10.0,
              ),
              blurRadius: 10.0,
              spreadRadius: -6.0,
            ),
          ],

          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(movieImg),
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.35),
                BlendMode.multiply,
              ),
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.bottomLeft,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,

              children: [
                // Country, Title, Language & Rating
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Movie Name
                    Container(
                      width: 230,
                      margin: const EdgeInsets.only(top: 4),
                      child: Text(
                        movieName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: whiteTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: semiBold
                        ),
                      ),
                    ),

                    // Movie Rate & Language
                    Row(
                      children: [
                        // Movie Rate
                        IntrinsicWidth(
                          child: Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
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
                                  movieRate,
                                  style: whiteTextStyle.copyWith(
                                      fontSize: 13,
                                      fontWeight: medium
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        // Movie Language
                        IntrinsicWidth(
                          child: Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(15),
                            ),

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                // Flag Icon
                                Icon(
                                  Icons.language,
                                  color: purpleColor,
                                  size: 18,
                                ),

                                const SizedBox(width: 8),

                                // Movie Language
                                Text(
                                  movieLanguage,
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
                  ],
                ),

                // Button See Detail
                GestureDetector(
                  onTap: () => onTap(),
                  child: Icon(Icons.play_circle_fill, color: whiteColor, size: 50),
                )
              ],
            ),
          ),
        ),
      );
  }
}

class RandomMovieLoadingCard extends StatelessWidget {
  const RandomMovieLoadingCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 260,

      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: const Offset(
              0.0,
              10.0,
            ),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          ),
        ],
      ),

      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class HomeMovieCard extends StatelessWidget {
  final String movieTitle;
  final String moviePoster;
  final String movieRate;

  const HomeMovieCard({super.key, required this.movieTitle, required this.moviePoster, required this.movieRate});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie Poster
          Container(
            width: 120,
            height: 160,

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(moviePoster),
                )
            ),

            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Align(
                alignment: Alignment.topRight,
                child: IntrinsicWidth(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
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
                          size: 14,
                        ),

                        const SizedBox(width: 4),

                        // Movie Rate Score
                        Text(
                          movieRate,
                          style: whiteTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: medium
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 6),

          // Movie Title
          SizedBox(
            width: 120,
            child: Text(
              movieTitle,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: medium
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AllMovieCardCustom extends StatelessWidget {
  final String movieTitle;
  final String moviePoster;
  final String movieRating;

  const AllMovieCardCustom({
    super.key,
    required this.movieTitle,
    required this.moviePoster, required this.movieRating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Movie Poster
        Container(
          height: 230,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(moviePoster),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.35),
                    BlendMode.multiply
                )
            ),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              // Movie Title
              Center(
                child: Text(
                  movieTitle,
                  textAlign: TextAlign.center,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                  style: whiteTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold
                  ),
                ),
              ),

              ratingInformation(
                  rating: movieRating,
                  xPadding: 6,
                  yPadding: 8,
                  fontSize: 12,
                  iconSize: 18
              )
            ],
          ),
        ),
      ],
    );
  }
}