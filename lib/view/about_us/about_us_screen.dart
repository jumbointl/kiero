
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_inappwebview/src/in_app_webview/in_app_webview_controller.dart';
import 'package:flutter_inappwebview/src/pull_to_refresh/pull_to_refresh_controller.dart';
import 'package:get/get.dart';
import 'package:kiero/utils/appconstant.dart';

import '../../controller/about_us_controller.dart';
import '../../utils/message.dart';
import '../common/common_screen.dart';

class AboutUsScreen extends CommonScreen {
  late AboutUsController model ;

  AboutUsScreen({super.url,super.title}
  ){
    super.url = aboutUsUrl ;
    super.title = Message.ABOUT_US;
  }

  @override
  void setControllerModel() {
    model = Get.put(AboutUsController());
  }

  @override
  void setPageIndex() {
    pageIndex = PAGE_ABOUT_US;
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
