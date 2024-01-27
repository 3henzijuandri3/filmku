import 'dart:convert';
import 'dart:developer';

import 'package:filmku/models/auth/account_state_model.dart';
import 'package:filmku/models/movie/detail_movie_model.dart';
import 'package:filmku/models/movie/poster_movie_model.dart';
import 'package:filmku/models/movie/random_movie_model.dart';
import 'package:filmku/services/auth_service.dart';
import 'package:http/http.dart' as http;

import '../shared/values.dart';

class MovieService{

  Future<bool> addToWatchlist(String movieId) async {
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
          "media_type": "movie",
          "media_id": movieId,
          "watchlist": true
        }),
      );

      log(res.statusCode.toString());

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

  Future<bool> removeFromWatchlist(String movieId) async {
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
          "media_type": "movie",
          "media_id": movieId,
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

  Future<AccountStateModel> getMovieStatus(String movieId) async {
    try{
      final String sessionId = await AuthService().getLocalSession();

      final res = await http.get(
          Uri.parse('$baseUrl/movie/$movieId/account_states?api_key=$apiKey&session_id=$sessionId'),
          headers: {
            'accept': 'application/json'
          }
      );

      if (jsonDecode(res.body) != null) {

        AccountStateModel movieStatus = AccountStateModel.fromJson(jsonDecode(res.body));

        return movieStatus;

      } else {
        log(res.body.toString());
        throw Exception("Results not found");
      }

    } catch(e) {
      rethrow;
    }
  }

  Future<List<PosterMovieModel>> getMovieWatchlist() async {
    try{
      final String sessionId = await AuthService().getLocalSession();
      final String userId = await AuthService().getLocalUserId();

      final res = await http.get(
          Uri.parse('$baseUrl/account/$userId/watchlist/movies?api_key=$apiKey&session_id=$sessionId'),
          headers: {
            'accept': 'application/json'
          }
      );

      if (jsonDecode(res.body)['results'] != null) {
        List<dynamic> results = jsonDecode(res.body)['results'];
        List<PosterMovieModel> watchlistMovie = results
            .map((movieJson) => PosterMovieModel.fromJson(movieJson)).toList();

        return watchlistMovie;

      } else {
        throw Exception("Results not found");
      }

    } catch(e) {
      rethrow;
    }
  }

  Future<List<RandomMovieModel>> getRandomMovie() async {
    try{

      final res = await http.get(
          Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'),
          headers: {
            'accept': 'application/json'
          }
      );

      if (jsonDecode(res.body)['results'] != null) {
        List<dynamic> results = jsonDecode(res.body)['results'];
        List<RandomMovieModel> listRandomMovieResponse = results
            .map((movieJson) => RandomMovieModel.fromJson(movieJson)).toList();

        return listRandomMovieResponse;

      } else {
        throw Exception("Results not found");
      }

    } catch(e) {
      rethrow;
    }
  }

  Future<List<PosterMovieModel>> getPopularMovie() async {
    try{

      final res = await http.get(
          Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'),
          headers: {
            'accept': 'application/json'
          }
      );

      if (jsonDecode(res.body)['results'] != null) {
        List<dynamic> results = jsonDecode(res.body)['results'];
        List<PosterMovieModel> listPopularMovie = results
            .map((movieJson) => PosterMovieModel.fromJson(movieJson)).toList();

        return listPopularMovie;

      } else {
        throw Exception("Results not found");
      }

    } catch(e) {
      rethrow;
    }
  }

  Future<List<PosterMovieModel>> getTopRatedMovie() async {
    try{

      final res = await http.get(
          Uri.parse('$baseUrl/movie/top_rated?api_key=$apiKey'),
          headers: {
            'accept': 'application/json'
          }
      );

      if (jsonDecode(res.body)['results'] != null) {
        List<dynamic> results = jsonDecode(res.body)['results'];
        List<PosterMovieModel> listTopRatedMovie = results
            .map((movieJson) => PosterMovieModel.fromJson(movieJson)).toList();

        return listTopRatedMovie;

      } else {
        throw Exception("Results not found");
      }

    } catch(e) {
      rethrow;
    }
  }

  Future<List<PosterMovieModel>> getNowPlayingMovie() async {
    try{

      final res = await http.get(
          Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey'),
          headers: {
            'accept': 'application/json'
          }
      );

      if (jsonDecode(res.body)['results'] != null) {
        List<dynamic> results = jsonDecode(res.body)['results'];
        List<PosterMovieModel> listNowPlayingMovie = results
            .map((movieJson) => PosterMovieModel.fromJson(movieJson)).toList();

        return listNowPlayingMovie;

      } else {
        throw Exception("Results not found");
      }

    } catch(e) {
      rethrow;
    }
  }

  Future<DetailMovieModel> getMovieDetail(String movieId) async {
    try{

      final res = await http.get(
          Uri.parse('$baseUrl/movie/$movieId?api_key=$apiKey'),
          headers: {
            'accept': 'application/json'
          }
      );

      if (jsonDecode(res.body) != null) {
        DetailMovieModel movieDetailResponse = DetailMovieModel.fromJson(jsonDecode(res.body));

        return movieDetailResponse;

      } else {
        throw Exception("Results not found");
      }

    } catch(e) {
      rethrow;
    }
  }

  Future<List<PosterMovieModel>> searchMovie(String movieName) async {
    try{

      final res = await http.get(
          Uri.parse('$baseUrl/search/movie?query=$movieName&api_key=$apiKey'),
          headers: {
            'accept': 'application/json'
          }
      );

      if (jsonDecode(res.body)['results'] != null) {
        List<dynamic> results = jsonDecode(res.body)['results'];
        List<PosterMovieModel> searchMovieResult = results
            .map((movieJson) => PosterMovieModel.fromJson(movieJson)).toList();

        return searchMovieResult;

      } else {
        throw Exception("Results not found");
      }

    } catch(e) {
      rethrow;
    }
  }
}