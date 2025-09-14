import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../view/home/home_screen.dart';

class WalkThroughController extends GetxController {
  var selectedPage = 0.obs;
  final PageController pageController = PageController();

  void changePage(){
    if(selectedPage<2){
      pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
      selectedPage++;
    }else{
      Get.off(HomeScreen());
    }
  }
}
