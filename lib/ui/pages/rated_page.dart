import 'package:filmku/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatedPage extends StatelessWidget {
  const RatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_rounded),
        ),
        title: const Text('Rated Movie'),
      ),

      body: Center(
        child: Text(
          'Coming Soon',
          style: blackTextStyle.copyWith(
            fontSize: 24,
            fontWeight: semiBold
          ),
        ),
      ),
    );
  }
}
