import 'dart:convert';

import 'package:filmku/models/movie/random_movie_model.dart';
import 'package:http/http.dart' as http;

import '../shared/values.dart';

class MovieService{

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

}