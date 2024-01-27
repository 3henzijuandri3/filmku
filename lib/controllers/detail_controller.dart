
import 'package:filmku/models/auth/account_state_model.dart';
import 'package:filmku/models/movie/detail_movie_model.dart';
import 'package:filmku/models/tv/detail_tv_model.dart';
import 'package:filmku/services/movie_service.dart';
import 'package:filmku/services/tv_service.dart';
import 'package:get/get.dart';

class DetailController extends GetxController{
  var isLoading = false.obs;
  var watchlistLoading = false.obs;

  final _addWatchlistResponse = Rxn<bool?>();
  bool? get addWatchlistResponse => _addWatchlistResponse.value;
  final _removeWatchlistResponse = Rxn<bool?>();
  bool? get removeWatchlistResponse => _removeWatchlistResponse.value;

  final _detailMovieResponse = Rxn<DetailMovieModel?>();
  DetailMovieModel? get detailMovieResponse => _detailMovieResponse.value;
  final _detailTvResponse = Rxn<TvDetailModel?>();
  TvDetailModel? get detailTvResponse => _detailTvResponse.value;

  final _movieStatusResponse = Rxn<AccountStateModel?>();
  AccountStateModel? get movieStatusResponse => _movieStatusResponse.value;
  final _tvStatusResponse = Rxn<AccountStateModel?>();
  AccountStateModel? get tvStatusResponse => _tvStatusResponse.value;

  Future<bool> addTvToWatchlist(String tvId) async {
    watchlistLoading(true);

    try{
      var addSuccess = await TvService().addToWatchlist(tvId);
      _addWatchlistResponse.value = addSuccess;

      if(addSuccess == true){
        return true;
      } else {
        return false;
      }

    } catch(e) {
      watchlistLoading(false);
      rethrow;

    } finally {
      watchlistLoading(false);
    }
  }

  Future<bool> removeTvFromWatchlist(String tvId) async {
    watchlistLoading(true);

    try{
      var removeSuccess = await TvService().removeFromWatchlist(tvId);
      _removeWatchlistResponse.value = removeSuccess;

      if(removeSuccess == true){
        return true;
      } else {
        return false;
      }

    } catch(e) {
      watchlistLoading(false);
      rethrow;

    } finally {
      watchlistLoading(false);
    }
  }

  Future<bool> addMovieToWatchlist(String movieId) async {
    watchlistLoading(true);

    try{
      var addSuccess = await MovieService().addToWatchlist(movieId);
      _addWatchlistResponse.value = addSuccess;

      if(addSuccess == true){
        return true;
      } else {
        return false;
      }

    } catch(e) {
      watchlistLoading(false);
      rethrow;

    } finally {
      watchlistLoading(false);
    }
  }

  Future<bool> removeMovieFromWatchlist(String movieId) async {
    watchlistLoading(true);

    try{
      var removeSuccess = await MovieService().removeFromWatchlist(movieId);
      _removeWatchlistResponse.value = removeSuccess;

      if(removeSuccess == true){
        return true;
      } else {
        return false;
      }

    } catch(e) {
      watchlistLoading(false);
      rethrow;

    } finally {
      watchlistLoading(false);
    }
  }

  Future<void> fetchTvDetailData(String tvId) async {
    isLoading(true);

    try{
      var tvDetails = await TvService().getTvDetail(tvId);
      _detailTvResponse.value = tvDetails;

      var tvStatus = await TvService().getTvStatus(tvId);
      _tvStatusResponse.value = tvStatus;

    } catch(e) {
      isLoading(false);
      rethrow;

    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchMovieDetailData(String movieId) async {
    isLoading(true);

    try{
      var movieDetails = await MovieService().getMovieDetail(movieId);
      _detailMovieResponse.value = movieDetails;

      var movieStatus = await MovieService().getMovieStatus(movieId);
      _movieStatusResponse.value = movieStatus;

    } catch(e) {
      isLoading(false);
      rethrow;

    } finally {
      isLoading(false);
    }
  }
}