import 'package:filmku/models/auth/user_profile_model.dart';
import 'package:filmku/services/auth_service.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController{
  var isLoading = false.obs;

  final _userDataResponse = Rxn<UserProfileModel?>();
  UserProfileModel? get userDataResponse => _userDataResponse.value;

  Future<void> fetchUserData() async {
    isLoading(true);

    try{
      var userProfileData = await AuthService().getUserProfileData();
      _userDataResponse.value = userProfileData;

    } catch(e) {
      isLoading(false);
      rethrow;

    } finally {
      isLoading(false);
    }
  }
}