import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../shared/theme.dart';
import '../../shared/values.dart';
import '../widgets/button_custom.dart';

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({super.key});

  final FlutterSecureStorage localStorage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [

          // Background Image
          Image.asset(
            bgOnboarding,
            fit: BoxFit.cover,
          ),

          // Black Overlay
          Container(
            decoration: const BoxDecoration(
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

          // Text
          Padding(
            padding: const EdgeInsets.only(left: 24, bottom: 60, right: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Track Your Favorite\nMovies & Series',
                  style: whiteTextStyle.copyWith(
                      fontSize: 34,
                      fontWeight: bold
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  'Manage Movies & Series With Filmku',
                  style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: regular
                  ),
                ),

                const SizedBox(height: 50),

                FilledButtonCustom(
                    width: double.infinity,
                    height: 50,
                    label: 'Get Started',
                    isNeon: true,
                    onTap: () async {
                      await localStorage.write(key: 'isBoarding', value: 'yes');
                      Get.offAllNamed('/');
                    }
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
