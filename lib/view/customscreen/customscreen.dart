import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kiero/controller/customcontroller.dart';
import 'package:kiero/utils/admob_service.dart';
import 'package:kiero/utils/appconstant.dart';

class CustomScreen extends StatelessWidget {
  const   CustomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final url = Get.arguments["customUrl"];
    final model = Get.put(CustomController());
    return Obx(
      () => FocusDetector(
        onFocusGained: () {
          model.getDarkMode();
        },
        child: Scaffold(
          backgroundColor: model.isDark.isTrue ? Colors.black : Colors.white,
          appBar: enableAppBar ? AppBar(
            backgroundColor: model.isDark.isTrue ? Colors.black : Colors.white,
            title: Text(
              Get.arguments["title"] ?? "Custom Screen",
              style: TextStyle(
                  color: model.isDark.isFalse ? Colors.black : Colors.white),
            ),
            iconTheme: IconThemeData(
                color: model.isDark.isFalse ? Colors.black : Colors.white),
          ) : null,
          bottomNavigationBar: !enableBannerAds
              ? const SizedBox.shrink()
              : SizedBox(
                  height: 50.0,
                  width: double.maxFinite,
                  child: AdWidget(
                      key: UniqueKey(),
                      ad: AdMobService.createBannerAd()..load()),
                ),
          body: SafeArea(
            child: InAppWebView(
              pullToRefreshController: model.pullToRefreshController,
              initialSettings: InAppWebViewSettings(
                mediaPlaybackRequiresUserGesture: false,
                useShouldOverrideUrlLoading: true,
                useOnDownloadStart: true,
                javaScriptEnabled: true,
                javaScriptCanOpenWindowsAutomatically: true,
                cacheEnabled: true,
                supportZoom: true,
                userAgent:
                "Mozilla/5.0 (Linux; Android 9; LG-H870 Build/PKQ1.190522.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/83.0.4103.106 Mobile Safari/537.36",
                verticalScrollBarEnabled: false,
                horizontalScrollBarEnabled: false,
                transparentBackground: true,
                allowFileAccessFromFileURLs: true,
                allowUniversalAccessFromFileURLs: true,
                useHybridComposition: true,
                //ios
                allowsInlineMediaPlayback: true,
                //android
                thirdPartyCookiesEnabled: true,
                allowFileAccess: true,

              ),
              initialUrlRequest: URLRequest(url: WebUri(url)),
              onWebViewCreated: (controller) async {},
              onLoadStart: (controller, url) async {
                model.pullToRefreshController.beginRefreshing();
                model.webViewController = controller;
              },
              shouldOverrideUrlLoading:
                  (controller, navigationAction) async {
                var url = navigationAction.request.url.toString();
                var uri = Uri.parse(url);

                if (Platform.isIOS && url.contains("geo")) {
                  url = url.replaceFirst(
                      'geo://', 'http://maps.apple.com/');
                } else if (url.contains("tel:") ||
                    url.contains("mailto:") ||
                    url.contains("play.google.com") ||
                    url.contains("maps") ||
                    url.contains("messenger.com")) {
                  url = Uri.encodeFull(url);
                  try {
                    if (await canLaunchUrl(uri)) {
                      launchUrl(uri);
                    } else {
                      launchUrl(uri);
                    }
                    return NavigationActionPolicy.CANCEL;
                  } catch (e) {
                    launchUrl(uri);
                    return NavigationActionPolicy.CANCEL;
                  }
                } else if (![
                  "http",
                  "https",
                  "file",
                  "chrome",
                  "data",
                  "javascript",
                ].contains(uri.scheme)) {
                  if (await canLaunchUrl(uri)) {
                    // Launch the App
                    await launchUrl(
                      uri,
                    );
                    // and cancel the request
                    return NavigationActionPolicy.CANCEL;
                  }
                }

                return NavigationActionPolicy.ALLOW;
              },
              onReceivedError: (controller, url, code) {
                model.pullToRefreshController.endRefreshing();
              },
              onLoadStop: (controller, url) async {
                model.pullToRefreshController.endRefreshing();
              },
              onProgressChanged: (controller, progress) {},
              onUpdateVisitedHistory: (controller, url, isReload) {},
              onConsoleMessage: (controller, consoleMessage) {
                print(consoleMessage);
              },
            ),
          ),
        ),
      ),
    );
  }
}
