import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kiero/utils/preferences.dart';
import 'package:kiero/view/customscreen/customscreen.dart';

class DemoController extends GetxController {
  final customUrl = TextEditingController();

  var isDark = false.obs;

  void onCustomUrlClicked(String url,String title) {
    Get.to(const CustomScreen(),
        arguments: {"customUrl": url,"title":title}, transition: Transition.rightToLeft);
  }

  @override
  void onClose() {
    customUrl.dispose();
    super.onClose();
  }

  Future<void> getDarkMode() async {
    Preferences preferences = Preferences();
    isDark.value = await preferences.getDarkMode();
  }

  @override
  void onInit() {
    getDarkMode();
    super.onInit();
  }
}
