import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../models/auth/user_profile_model.dart';
import '../shared/values.dart';

class AuthService {
  Future<UserProfileModel> getUserProfileData() async {
    try {
      final String sessionId = await getLocalSession();

      if (sessionId.isEmpty) {
        throw Exception('Session ID not found');
      }

      final res = await http.get(
        Uri.parse('$baseUrl/account?session_id=$sessionId&api_key=$apiKey'),
        headers: {'accept': 'application/json'},
      );

      if (res.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(res.body);
        final UserProfileModel userProfile = UserProfileModel.fromJson(responseData);

        await storeUserIdToLocal(userProfile.id.toString());

        return userProfile;

      } else {
        throw Exception("Failed to fetch user profile data: ${res.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getRequestToken() async {
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/authentication/token/new?api_key=$apiKey'),
        headers: {'accept': 'application/json'},
      );

      if (res.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(res.body);
        final String requestToken = responseData['request_token'];
        return requestToken;

      } else {
        throw Exception("Failed to get request token: ${res.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getSessionId(String requestToken) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/authentication/session/new?api_key=$apiKey'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'request_token': requestToken}),
      );

      if (res.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(res.body);
        final String sessionId = responseData['session_id'];

        await storeSessionToLocal(sessionId);

        return sessionId;

      } else {
        throw Exception("Failed to create session ID: ${res.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> storeSessionToLocal(String sessionId) async {

    try{

      const storage = FlutterSecureStorage();
      await storage.write(key: 'sessionId', value: sessionId);

    } catch(e) {
      rethrow;
    }

  }

  Future<void> storeUserIdToLocal(String userId) async {

    try{
      const storage = FlutterSecureStorage();
      await storage.write(key: 'userId', value: userId);

    } catch(e) {
      rethrow;
    }

  }

  Future<String> getLocalSession() async {
    try{
      String sessionId = '';

      const storage = FlutterSecureStorage();
      String? values = await storage.read(key: 'sessionId');

      if(values != null){
        sessionId = values;
      }

      return sessionId;

    } catch(e){
      rethrow;
    }
  }

  Future<String> getLocalUserId() async {
    try{
      String sessionId = '';

      const storage = FlutterSecureStorage();
      String? values = await storage.read(key: 'userId');

      if(values != null){
        sessionId = values;
      }

      return sessionId;

    } catch(e){
      rethrow;
    }
  }

  Future<void> clearLocalStorage() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}
