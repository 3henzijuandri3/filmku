import 'package:filmku/models/movie/random_movie_model.dart';
import 'package:filmku/services/movie_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  var isLoading = false.obs;
  var selectedMenu = 0.obs;

  final _randomMovieResponse = Rxn<List<RandomMovieModel>?>();
  List<RandomMovieModel>? get randomMovieResponse => _randomMovieResponse.value;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  void selectMenu(int menu){
    selectedMenu.value = menu;
  }

  Future<void> fetchHomeData() async {
    isLoading(true);

    try{
      var listRandomMovieData = await MovieService().getRandomMovie();
      _randomMovieResponse.value = listRandomMovieData;

    } catch(e) {
      isLoading(false);
      rethrow;

    } finally {
      isLoading(false);
    }
  }

  clearState(){
    Get.delete<HomeController>(force: true);
  }
}