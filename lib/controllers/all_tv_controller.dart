import 'package:get/get.dart';

import '../models/tv/poster_tv_model.dart';
import '../services/tv_service.dart';

class AllTvController extends GetxController{
  var isSearching = false.obs;

  var isPopularLoading = false.obs;
  var isTopRatedLoading = false.obs;
  var isNowPlayingLoading = false.obs;
  var searchLoading = false.obs;

  final _popularTvResponse = Rxn<List<PosterTvModel>?>();
  List<PosterTvModel>? get popularTvResponse => _popularTvResponse.value;

  final _topRatedTvResponse = Rxn<List<PosterTvModel>?>();
  List<PosterTvModel>? get topRatedTvResponse => _topRatedTvResponse.value;

  final _nowPlayingTvResponse = Rxn<List<PosterTvModel>?>();
  List<PosterTvModel>? get nowPlayingTvResponse => _nowPlayingTvResponse.value;

  final _searchTvResponse = Rxn<List<PosterTvModel>?>();
  List<PosterTvModel>? get searchTvResponse => _searchTvResponse.value;

  Future<void> searchTv(String tvName) async {
    searchLoading(true);

    try{
      var searchTvResult = await TvService().searchMovie(tvName);
      _searchTvResponse.value = searchTvResult;

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
      var listNowPlayingTv = await TvService().getNowPlayingTv();
      _nowPlayingTvResponse.value = listNowPlayingTv;

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
      var listPopularTv = await TvService().getPopularTv();
      _popularTvResponse.value = listPopularTv;

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
      var listTopRatedTv = await TvService().getTopRatedTv();
      _topRatedTvResponse.value = listTopRatedTv;

    } catch(e) {
      isTopRatedLoading(false);
      rethrow;

    } finally {
      isTopRatedLoading(false);
    }
  }
}