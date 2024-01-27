import 'dart:convert';

import 'package:filmku/models/tv/detail_tv_model.dart';
import 'package:filmku/models/tv/poster_tv_model.dart';
import 'package:http/http.dart' as http;

import '../models/auth/account_state_model.dart';
import '../shared/values.dart';
import 'auth_service.dart';

class TvService{

  Future<AccountStateModel> getTvStatus(String tvId) async {
    try{
      final String sessionId = await AuthService().getLocalSession();

      final res = await http.get(
          Uri.parse('$baseUrl/tv/$tvId/account_states?api_key=$apiKey&session_id=$sessionId'),
          headers: {
            'accept': 'application/json'
          }
      );

      if (jsonDecode(res.body) != null) {

        AccountStateModel tvStatus = AccountStateModel.fromJson(jsonDecode(res.body));

        return tvStatus;

      } else {
        throw Exception("Results not found");
      }

    } catch(e) {
      rethrow;
    }
  }

  Future<bool> addToWatchlist(String tvId) async {
    try {
      final String sessionId = await AuthService().getLocalSession();
      final String userId = await AuthService().getLocalUserId();

      final res = await http.post(
        Uri.parse('$baseUrl/account/$userId/watchlist?api_key=$apiKey&session_id=$sessionId'),

        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },

        body: jsonEncode({
          "media_type": "tv",
          "media_id": tvId,
          "watchlist": true
        }),
      );

      if (res.statusCode == 201) {
        bool isAddSuccess = jsonDecode(res.body)['success'];

        return isAddSuccess;

      } else {
        throw Exception("Failed to Add: ${res.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> removeFromWatchlist(String tvId) async {
    try {
      final String sessionId = await AuthService().getLocalSession();
      final String userId = await AuthService().getLocalUserId();

      final res = await http.post(
        Uri.parse('$baseUrl/account/$userId/watchlist?api_key=$apiKey&session_id=$sessionId'),

        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },

        body: jsonEncode({
          "media_type": "tv",
          "media_id": tvId,
          "watchlist": false
        }),
      );

      if (res.statusCode == 200) {
        bool isRemoveSuccess = jsonDecode(res.body)['success'];

        return isRemoveSuccess;

      } else {
        throw Exception("Failed to Remove: ${res.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PosterTvModel>> getTvWatchlist() async {
    try{

      final String sessionId = await AuthService().getLocalSession();
      final String userId = await AuthService().getLocalUserId();

      final res = await http.get(
          Uri.parse('$baseUrl/account/$userId/watchlist/tv?api_key=$apiKey&session_id=$sessionId'),
          headers: {
            'accept': 'application/json'
          }
      );

      if (jsonDecode(res.body)['results'] != null) {
        List<dynamic> results = jsonDecode(res.body)['results'];
        List<PosterTvModel> watchlistTv = results
            .map((movieJson) => PosterTvModel.fromJson(movieJson)).toList();

        return watchlistTv;

      } else {
        throw Exception("Results not found");
      }

    } catch(e) {
      rethrow;
    }
  }

  Future<List<PosterTvModel>> getPopularTv() async {
    try{

      final res = await http.get(
          Uri.parse('$baseUrl/tv/popular?api_key=$apiKey'),
          headers: {
            'accept': 'application/json'
          }
      );

      if (jsonDecode(res.body)['results'] != null) {
        List<dynamic> results = jsonDecode(res.body)['results'];
        List<PosterTvModel> listPopularTv = results
            .map((tvJson) => PosterTvModel.fromJson(tvJson)).toList();

        return listPopularTv;

      } else {
        throw Exception("Results not found");
      }

    } catch(e) {
      rethrow;
    }
  }

  Future<List<PosterTvModel>> getTopRatedTv() async {
    try{

      final res = await http.get(
          Uri.parse('$baseUrl/tv/top_rated?api_key=$apiKey'),
          headers: {
            'accept': 'application/json'
          }
      );

      if (jsonDecode(res.body)['results'] != null) {
        List<dynamic> results = jsonDecode(res.body)['results'];
        List<PosterTvModel> listTopRatedTv = results
            .map((tvJson) => PosterTvModel.fromJson(tvJson)).toList();

        return listTopRatedTv;

      } else {
        throw Exception("Results not found");
      }

    } catch(e) {
      rethrow;
    }
  }

  Future<TvDetailModel> getTvDetail(String tvId) async {
    try{

      final res = await http.get(
          Uri.parse('$baseUrl/tv/$tvId?api_key=$apiKey'),
          headers: {
            'accept': 'application/json'
          }
      );

      if (jsonDecode(res.body) != null) {
        TvDetailModel tvDetailResponse = TvDetailModel.fromJson(jsonDecode(res.body));

        return tvDetailResponse;

      } else {
        throw Exception("Results not found");
      }

    } catch(e) {
      rethrow;
    }
  }

  Future<List<PosterTvModel>> getNowPlayingTv() async {
    try{

      final res = await http.get(
          Uri.parse('$baseUrl/tv/on_the_air?api_key=$apiKey'),
          headers: {
            'accept': 'application/json'
          }
      );

      if (jsonDecode(res.body)['results'] != null) {
        List<dynamic> results = jsonDecode(res.body)['results'];
        List<PosterTvModel> listNowPlayingTv = results
            .map((movieJson) => PosterTvModel.fromJson(movieJson)).toList();

        return listNowPlayingTv;

      } else {
        throw Exception("Results not found");
      }

    } catch(e) {
      rethrow;
    }
  }

  Future<List<PosterTvModel>> searchMovie(String tvName) async {
    try{

      final res = await http.get(
          Uri.parse('$baseUrl/search/tv?query=$tvName&api_key=$apiKey'),
          headers: {
            'accept': 'application/json'
          }
      );

      if (jsonDecode(res.body)['results'] != null) {
        List<dynamic> results = jsonDecode(res.body)['results'];
        List<PosterTvModel> searchTvResult = results
            .map((movieJson) => PosterTvModel.fromJson(movieJson)).toList();

        return searchTvResult;

      } else {
        throw Exception("Results not found");
      }

    } catch(e) {
      rethrow;
    }
  }
}