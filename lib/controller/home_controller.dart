import 'dart:io';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:kiero/controller/controller_model.dart';



class HomeController extends ControllerModel {


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

}
