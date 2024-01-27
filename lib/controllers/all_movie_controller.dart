import 'package:get/get.dart';

import '../models/movie/poster_movie_model.dart';
import '../services/movie_service.dart';

class AllMovieController extends GetxController{
  var isSearching = false.obs;

  var isPopularLoading = false.obs;
  var isTopRatedLoading = false.obs;
  var isNowPlayingLoading = false.obs;
  var searchLoading = false.obs;

  final _popularMovieResponse = Rxn<List<PosterMovieModel>?>();
  List<PosterMovieModel>? get popularMovieResponse => _popularMovieResponse.value;

  final _topRatedMovieResponse = Rxn<List<PosterMovieModel>?>();
  List<PosterMovieModel>? get topRatedMovieResponse => _topRatedMovieResponse.value;

  final _nowPlayingMovieResponse = Rxn<List<PosterMovieModel>?>();
  List<PosterMovieModel>? get nowPlayingMovieResponse => _nowPlayingMovieResponse.value;

  final _searchMovieResponse = Rxn<List<PosterMovieModel>?>();
  List<PosterMovieModel>? get searchMovieResponse => _searchMovieResponse.value;

  Future<void> searchMovie(String movieName) async {
    searchLoading(true);

    try{
      var searchMovieResult = await MovieService().searchMovie(movieName);
      _searchMovieResponse.value = searchMovieResult;

    } catch(e) {
      searchLoading(false);
      rethrow;

    } finally {
      searchLoading(false);
    }
  }

  Future<void> fetchNowPlayingData() async {
    isNowPlayingLoading(true);

    try{
      var listNowPlayingMovie = await MovieService().getNowPlayingMovie();
      _nowPlayingMovieResponse.value = listNowPlayingMovie;

    } catch(e) {
      isNowPlayingLoading(false);
      rethrow;

    } finally {
      isNowPlayingLoading(false);
    }
  }

  Future<void> fetchPopularData() async {
    isPopularLoading(true);

    try{
      var listPopularMovie = await MovieService().getPopularMovie();
      _popularMovieResponse.value = listPopularMovie;

    } catch(e) {
      isPopularLoading(false);
      rethrow;

    } finally {
      isPopularLoading(false);
    }
  }

  Future<void> fetcTopRatedData() async {
    isTopRatedLoading(true);

    try{
      var listTopRatedMovie = await MovieService().getTopRatedMovie();
      _topRatedMovieResponse.value = listTopRatedMovie;

    } catch(e) {
      isTopRatedLoading(false);
      rethrow;

    } finally {
      isTopRatedLoading(false);
    }
  }
}