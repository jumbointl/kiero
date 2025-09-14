import 'dart:async';

import 'package:get/get.dart';
import 'package:kiero/utils/appconstant.dart';
import 'package:kiero/view/walkthroughscreen/walkthoughscreen.dart';

import '../view/home/home_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Timer(Duration(seconds: splashDuration), () {
      Get.off(enableWalkThrough ? WalkThoughScreen() :HomeScreen(),
        transition: Transition.fade , duration: Duration(seconds: 2),
       );
    });
    super.onInit();
  }
}
