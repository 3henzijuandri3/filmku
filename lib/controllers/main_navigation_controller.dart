import 'package:get/get.dart';

class MainNavigationController extends GetxController{
  final _indexPage = 0.obs;
  int get indexPage => _indexPage.value;
  set indexPage(n) => _indexPage.value = n;
}
