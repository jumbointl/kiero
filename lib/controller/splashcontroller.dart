import 'dart:async';

import 'package:get/get.dart';
import 'package:kiero/utils/appconstant.dart';
import 'package:kiero/view/mainscreen/mainscreen.dart';
import 'package:kiero/view/walkthroughscreen/walkthoughscreen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Timer(Duration(seconds: splashDuration), () {
      Get.off(enableWalkThrough ? WalkThoughScreen() : MainScreen(),
        transition: Transition.circularReveal , duration: Duration(seconds: 2),
       );
    });
    super.onInit();
  }
}
