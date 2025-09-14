import 'package:flutter/src/widgets/framework.dart';
import 'package:kiero/controller/controller_model.dart';


class SettingController extends ControllerModel {



  @override
  void onInit() {
    showAds();
    getDarkMode();
    super.onInit();
  }

  @override
  Future<void> onItemTapped(BuildContext context, int index) {
    // TODO: implement onItemTapped
    throw UnimplementedError();
  }



}
