import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:kiero/controller/controller_model.dart';
import 'package:kiero/utils/admob_service.dart';
import 'package:kiero/utils/appconstant.dart';

class CustomController extends ControllerModel {
  InAppWebViewController? webViewController;
  late PullToRefreshController pullToRefreshController;

  var isDark = false.obs;

  final adUrlFilters = [
  ];
  final List<ContentBlocker> contentBlockers = [];
  var contentBlockerEnabled = true;

  @override
  void onInit() {
    getDarkMode();
    contentBlockers.add(ContentBlocker(
        trigger: ContentBlockerTrigger(
          urlFilter: ".*",
        ),
        action: ContentBlockerAction(
            type: ContentBlockerActionType.CSS_DISPLAY_NONE,
            selector: ".banner, .banners, .ads, .ad, .advert")));

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
      debugPrint(e.toString());
    }

    showAds();
    super.onInit();
  }

  showAds() {
    if (enableInterstitialAds) {
      AdMobService.createInterstitialAd();
      AdMobService.showInterstitialAd();
    }
  }


}
