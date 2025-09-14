
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:kiero/utils/appconstant.dart';

import '../../controller/login_controller.dart';
import '../../utils/message.dart';
import '../common/common_screen.dart';

class LoginScreen extends CommonScreen {
  late LoginController model;



  LoginScreen({super.url,super.title}
  ){
    super.url = loginUrl ;
    super.title = Message.LOGIN;
  }

  @override
  void setControllerModel() {
    model = Get.put(LoginController());
  }

  @override
  void setPageIndex() {
    pageIndex = PAGE_LOGIN;
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
