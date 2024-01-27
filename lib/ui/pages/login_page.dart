import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../shared/theme.dart';
import '../widgets/button_custom.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final authStateController = Get.put(AuthContrroller());

  Future<void> getRequestToken() async {
    final getTokenSuccess = await authStateController.getRequestToken();

    if(getTokenSuccess){
      final requestToken = authStateController.requestToken;
      Get.toNamed('/tmdb_web', arguments: requestToken.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        final isLoading = authStateController.isLoading.value;

        return Stack(
          children: [
            // Login Text & Button
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  // Text
                  Text(
                    'Login To Your Account\nFor Full Feature Access',
                    textAlign: TextAlign.center,
                    style: blackTextStyle.copyWith(
                        fontSize: 22,
                        fontWeight: semiBold
                    ),
                  ),

                  const SizedBox(height: 20),

                  //To Login Button
                  FilledButtonCustom(
                      width: 280,
                      height: 50,
                      label: 'Sign In To Your Account',
                      onTap: (){
                        getRequestToken();
                      }
                  ),
                ],
              ),
            ),

            if(isLoading)
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
      }),
    );
  }
}
