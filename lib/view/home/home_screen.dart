
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:kiero/utils/appconstant.dart';

import '../../controller/home_controller.dart';
import '../../utils/message.dart';
import '../common/common_screen.dart';

class HomeScreen extends CommonScreen {
  late HomeController model;



  HomeScreen({super.url,super.title}
  ){
    super.url = mainUrl ;
    super.title = Message.HOME;
  }

  @override
  void setControllerModel() {
    model = Get.put(HomeController());
  }

  @override
  void setPageIndex() {
    pageIndex = PAGE_MAIN;
    print('pageIndex $pageIndex');
  }
  @override
  void getDarkMode() {
    model.getDarkMode();
  }

  @override
  RxBool get isDark => model.isDark;

  @override
  RxBool get isLoading =>model.isLoading;

  @override
  void onItemTapped(BuildContext context, int index) {
    model.onItemTapped(context, index);
  }

  @override
  void onWillPop(BuildContext context) {
    model.onWillPop(context);
  }

  @override
  PullToRefreshController get pullToRefreshController => model.pullToRefreshController;

  @override
  RxInt get selectedIndex => model.selectedIndex;

  @override
  void setWebViewController(InAppWebViewController controller) {
    model.webViewController = controller;
  }

  @override
  InAppWebViewController? get webViewController => model.webViewController;
}
