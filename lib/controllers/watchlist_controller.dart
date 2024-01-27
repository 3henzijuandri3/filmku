import 'package:filmku/services/tv_service.dart';
import 'package:get/get.dart';

import '../models/movie/poster_movie_model.dart';
import '../models/tv/poster_tv_model.dart';
import '../services/movie_service.dart';

class WacthlistController extends GetxController{
  var isMovieLoading = false.obs;
  var isTvLoading = false.obs;

  final _watchlistMovieResponse = Rxn<List<PosterMovieModel>?>();
  List<PosterMovieModel>? get watchlistMovieResponse => _watchlistMovieResponse.value;

  final _watchlistTvResponse = Rxn<List<PosterTvModel>?>();
  List<PosterTvModel>? get watchlistTvResponse => _watchlistTvResponse.value;

  Future<void> fecthMovieWacthlist() async {
    isMovieLoading(true);

    try{

      var watchlistMovie = await MovieService().getMovieWatchlist();
      _watchlistMovieResponse.value = watchlistMovie;

    } catch(e) {
      isMovieLoading(false);
      rethrow;

    } finally {
      isMovieLoading(false);
    }
  }

  Future<void> fecthTvWatchlist() async {
    isTvLoading(true);

    try{
      var watchlistTv = await TvService().getTvWatchlist();
      _watchlistTvResponse.value = watchlistTv;

    } catch(e) {
      isTvLoading(false);
      rethrow;

    } finally {
      isTvLoading(false);
    }
  }
}