import 'package:get/get.dart';

import '../../models/movie/poster_movie_model.dart';
import '../../models/movie/random_movie_model.dart';
import '../../models/tv/poster_tv_model.dart';
import '../../services/movie_service.dart';
import '../../services/tv_service.dart';

class HomeController extends GetxController{
  var selectedMenu = 0.obs;
  var menuTitle = 'Movies'.obs;
  var isRandomLoading = false.obs;
  var isPopularLoading = false.obs;
  var isTopRatedLoading = false.obs;

  final _randomMovieResponse = Rxn<List<RandomMovieModel>?>();
  List<RandomMovieModel>? get randomMovieResponse => _randomMovieResponse.value;

  final _popularMovieResponse = Rxn<List<PosterMovieModel>?>();
  List<PosterMovieModel>? get popularMovieResponse => _popularMovieResponse.value;

  final _popularTvResponse = Rxn<List<PosterTvModel>?>();
  List<PosterTvModel>? get popularTvResponse => _popularTvResponse.value;

  final _topRatedMovieResponse = Rxn<List<PosterMovieModel>?>();
  List<PosterMovieModel>? get topRatedMovieResponse => _topRatedMovieResponse.value;

  final _topRatedTvResponse = Rxn<List<PosterTvModel>?>();
  List<PosterTvModel>? get topRatedTvResponse => _topRatedTvResponse.value;

  @override
  void onInit() {
    super.onInit();
    fetchRandomMovie();
    fetchPopularData();
    fetcTopRatedData();
  }

  void selectMenu(int menu){
    selectedMenu.value = menu;
  }

  void changeMenuTitle(String title){
    menuTitle.value = title;
  }

  Future<void> fetchPopularData() async {
    isPopularLoading(true);

    try{
      var listPopularMovie = await MovieService().getPopularMovie();
      _popularMovieResponse.value = listPopularMovie;

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
      var listTopRatedMovie = await MovieService().getTopRatedMovie();
      _topRatedMovieResponse.value = listTopRatedMovie;

      var listTopRatedTv = await TvService().getTopRatedTv();
      _topRatedTvResponse.value = listTopRatedTv;

    } catch(e) {
      isTopRatedLoading(false);
      rethrow;

    } finally {
      isTopRatedLoading(false);
    }
  }

  Future<void> fetchRandomMovie() async {
    isRandomLoading(true);

    try{
      var listRandomMovieData = await MovieService().getRandomMovie();
      _randomMovieResponse.value = listRandomMovieData;

    } catch(e) {
      isRandomLoading(false);
      rethrow;

    } finally {
      isRandomLoading(false);
    }
  }

  clearState(){
    Get.delete<HomeController>(force: true);
  }
}