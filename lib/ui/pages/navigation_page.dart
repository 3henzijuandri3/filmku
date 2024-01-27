import 'package:filmku/controllers/main_navigation_controller.dart';
import 'package:filmku/shared/theme.dart';
import 'package:filmku/ui/pages/all_movie_page.dart';
import 'package:filmku/ui/pages/all_tv_page.dart';
import 'package:filmku/ui/pages/home_page.dart';
import 'package:filmku/ui/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationPage extends StatelessWidget {
  NavigationPage({super.key});
  final navigationStateController = Get.put(MainNavigationController());


  final List<Map> listNav = [
    {'icon': const Icon(Icons.home), 'label': 'Home'},
    {'icon': const Icon(Icons.video_camera_back), 'label': 'Movies'},
    {'icon': const Icon(Icons.tv), 'label': 'Tv Shows'},
    {'icon': const Icon(Icons.person), 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Obx(() {
        if (navigationStateController.indexPage == 1) {
          return const AllMoviePage();
        } else if(navigationStateController.indexPage == 2){
          return const AllTvPage();
        } else if(navigationStateController.indexPage == 3){
          return ProfilePage();
        }
        return HomePage();
      }),

      bottomNavigationBar: Obx(() {
        return Material(
          elevation: 8,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 8, bottom: 6),

            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.black,
              elevation: 0,

              currentIndex: navigationStateController.indexPage,
              onTap: (value) => navigationStateController.indexPage = value,

              selectedFontSize: 12,
              selectedIconTheme: IconThemeData(
                color: purpleColor,
              ),
              selectedLabelStyle: blackTextStyle.copyWith(
                fontWeight: bold
              ),

              items: listNav.map((e) {
                return BottomNavigationBarItem(
                  icon: e['icon'],
                  label: e['label'],
                );
              }).toList(),
            ),
          ),
        );
      }),
    );
  }
}
