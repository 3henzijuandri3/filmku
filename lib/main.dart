import 'package:filmku/shared/theme.dart';
import 'package:filmku/ui/pages/home_page.dart';
import 'package:filmku/ui/pages/onboarding_page.dart';
import 'package:filmku/ui/pages/splash_screen_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'filmku',
      debugShowCheckedModeBanner: false ,
      theme: ThemeData(
          scaffoldBackgroundColor: lightBackgroundColor,

          appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
            backgroundColor: lightBackgroundColor,

            iconTheme: IconThemeData(
              color: blackColor,
            ),

            titleTextStyle: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold
            ),
          )
      ),

      home: HomePage(),
    );
  }
}