import 'dart:io';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:kiero/controller/controller_model.dart';
import 'package:kiero/view/demoscreen/demoscreen.dart';


class MainController extends ControllerModel {
  InAppWebViewController? webViewController;
  late PullToRefreshController pullToRefreshController;



  @override
  Future<void> onInit() async {
    getDarkMode();
    try {
      pullToRefreshController = PullToRefreshController(
        onRefresh: () async {
          if (Platform.isAndroid) {
            webViewController!.reload();
          } else if (Platform.isIOS) {
            webViewController!.loadUrl(
                urlRequest: URLRequest(url: await webViewController!.getUrl()));
          }
        },
      );
    } on Exception catch (e) {
       print(e);
    }
    super.onInit();
  }

  void onDemoScreenClicked() {
    Get.to(DemoScreen(), transition: Transition.leftToRight);
  }



}
