import 'package:get/get.dart';

import '../services/auth_service.dart';

class AuthContrroller extends GetxController{
  var isLoading = false.obs;

  final _requestToken = Rxn<String?>();
  String? get requestToken => _requestToken.value;

  final _sessionId = Rxn<String?>();
  String? get sessionId => _sessionId.value;

  Future<bool> createSessionId(String requestToken) async {
    isLoading(true);

    try{
      var id = await AuthService().getSessionId(requestToken);
      _sessionId.value = id;

      if(sessionId != null){
        return true;
      } else {
        return false;
      }

    } catch(e) {
      isLoading(false);
      rethrow;

    } finally {
      isLoading(false);
    }
  }

  Future<bool> getRequestToken() async {
    isLoading(true);

    try{
      var token = await AuthService().getRequestToken();
      _requestToken.value = token;

      if(requestToken != null){
        return true;
      } else {
        return false;
      }

    } catch(e) {
      isLoading(false);
      rethrow;

    } finally {
      isLoading(false);
    }
  }

}