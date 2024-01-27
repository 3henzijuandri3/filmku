import 'dart:developer';

import 'package:filmku/controllers/main_navigation_controller.dart';
import 'package:filmku/controllers/user_profile_controller.dart';
import 'package:filmku/services/auth_service.dart';
import 'package:filmku/shared/theme.dart';
import 'package:filmku/shared/values.dart';
import 'package:filmku/ui/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final navigationStateController = Get.put(MainNavigationController());
  final profileStateController = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: AuthService().getLocalSession(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());

        } else if (snapshot.hasError) {
          return const Center(child: Text('Something Went Wrong :('));

        } else {
          if(snapshot.data!.isNotEmpty && snapshot.data != null){
            profileStateController.fetchUserData();

            return Scaffold(
              appBar: AppBar(
                leading: GestureDetector(
                  onTap: (){
                    navigationStateController.indexPage = 0;
                  },
                  child: const Icon(Icons.arrow_back_rounded),
                ),

                title: const Text('My Profile'),
              ),

              body: PopScope(
                canPop: false,
                onPopInvoked: (didpop){
                  if(didpop){
                    return;
                  }
                  navigationStateController.indexPage = 0;
                },
                
                child: userProfileView(),
              ),
            );

          } else {
            return LoginPage();
          }
        }
      },
    );
  }

  Widget userProfileView(){
    return SafeArea(
      child: GetX(
          init: profileStateController,
          builder: (controller){
            final isLoading = controller.isLoading.value;
            final userProfileData = controller.userDataResponse;

            if(isLoading){
              return const Center(child: CircularProgressIndicator());
            }

            if(userProfileData != null){
              return IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(30),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: whiteColor
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // User Profile Image
                        Container(
                          width: 120,
                          height: 120,

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  apiImgUrl+userProfileData.avatar!.tmdb!.avatarPath.toString()
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Username
                        SizedBox(
                          width: 150,
                          child: Text(
                              userProfileData.username.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: blackTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: semiBold
                              )
                          ),
                        ),

                        const SizedBox(height: 40),

                        // See Watch List
                        GestureDetector(
                          onTap: (){
                            log(userProfileData.id.toString());
                            Get.toNamed('/watchlist', arguments: userProfileData.id.toString());
                          },

                          child: Row(
                            children: [
                              Icon(Icons.list_alt, size: 24, color: purpleColor),

                              const SizedBox(width: 18),

                              Text(
                                  'Watchlist',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: semiBold
                                  )
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Your Rated Movie
                        GestureDetector(
                          onTap: (){
                            Get.toNamed('/rated');
                          },

                          child: Row(
                            children: [
                              Icon(Icons.star_rate_sharp, size: 24, color: purpleColor),

                              const SizedBox(width: 18),

                              Text(
                                  'Rated Movie',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold
                                  )
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Logout
                        GestureDetector(
                          onTap: (){
                            AuthService().clearLocalStorage();
                            navigationStateController.indexPage = 0;
                            Get.offAllNamed('/');
                          },

                          child: Row(
                            children: [
                              Icon(Icons.logout, size: 24, color: purpleColor),

                              const SizedBox(width: 18),

                              Text(
                                  'Logout',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold
                                  )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return const Center(child: Text('Something Wrong :('));
          }),
    );
  }
}
