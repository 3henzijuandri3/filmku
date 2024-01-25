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
        child: GetX(
            init: homeStateController,
            builder: (controller){
              final isLoading = controller.isLoading.value;
              final selectedMenu = controller.selectedMenu.value;
              final listRandomMovie = controller.randomMovieResponse;

              if(isLoading){
                return const Center(child: CircularProgressIndicator(),);
              }

              if(listRandomMovie != null){
                var randomMovie = listRandomMovie.toList()..shuffle();

                return ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    // Profile Section
                    profileSection(),

                    const SizedBox(height: 36),

                    // Random Movie Card
                    RandomMovieCard(
                      movieName: randomMovie[0].originalTitle.toString(),
                      movieRate: randomMovie[0].voteAverage!.toStringAsFixed(1),
                      movieImg: apiImgUrl+randomMovie[0].backdropPath.toString(),
                      movieLanguage: randomMovie[0].originalLanguage.toString(),

                      onTap: (){

                      },
                    ),

                    const SizedBox(height: 34),

                    homeMenuSection(selectedMenu),
                  ],
                );
              }

              return const Center(child: Text('Something Went Wrong :('));
            }),
      ),
    );
  }

  Widget profileSection(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile Picture & Welcome Text
        Row(
          children: [
            // Profile Picture
            Container(
              width: 50,
              height: 50,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(dummyProfile)
                )
              ),
            ),

            const SizedBox(width: 8),

            // Login Text
            // Text(
            //   'Press To Login',
            //   style: blackTextStyle.copyWith(
            //       fontSize: 18,
            //       fontWeight: semiBold
            //   ),
            // ),

            // Welcome Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Back
                Text(
                  'Welcome Back!',
                  style: greyTextStyle.copyWith(
                    fontSize: 15,
                    fontWeight: medium
                  ),
                ),

                // Profile Name
                Text(
                  'Henzi Juandri',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold
                  ),
                ),
              ],
            ),
          ],
        ),

        // Search Button
        GestureDetector(
          child: Icon(
            Icons.search,
            size: 25,
            color: blackColor,
          ),
        )
      ],
    );
  }

  Widget homeMenuSection(int select){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Movie Option Menu
        InkWell(
          onTap: (){

          },

          child: MenuButtonCustom(
              menuTitle: 'Movies',
              menuIcon: Icons.videocam,
              isSelected: select == 0 ? true : false
          ),
        ),

        // TV Series Option Menu
        InkWell(
          onTap: (){

          },

          child: MenuButtonCustom(
              menuTitle: 'TV Series',
              menuIcon: Icons.tv,
              isSelected: select == 1 ? true : false
          ),
        ),

        // Popular People Option Menu
        InkWell(
          onTap: (){

          },

          child: MenuButtonCustom(
              menuTitle: 'People',
              menuIcon: Icons.supervisor_account_rounded,
              isSelected: select == 2 ? true : false
          ),
        ),
      ],
    );
  }

  Widget movieSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Movies Pick',
          style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semiBold
          ),
        ),

        const SizedBox(height: 14),

        // Movie List
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            HomeMovieCard(movieTitle: 'Spiderman 2', moviePoster: bgOnboarding)

          ],
        ),
      ],
    );
  }
}
