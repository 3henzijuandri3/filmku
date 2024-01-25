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
                // Country, Title & Rating
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
                            fontSize: 20,
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

                        const SizedBox(width: 4),

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
                  child: Icon(Icons.play_circle_fill, color: whiteColor, size: 44),
                )
              ],
            ),
          ),
        ),
      );
  }
}

class HomeMovieCard extends StatelessWidget {
  final String movieTitle;
  final String moviePoster;

  const HomeMovieCard({super.key, required this.movieTitle, required this.moviePoster});

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
            height: 150,

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(moviePoster),
                )
            ),
          ),

          const SizedBox(height: 6),

          // Movie Title
          SizedBox(
            width: 120,
            child: Text(
              movieTitle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
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