import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kiero/controller/maincontroller.dart';
import 'package:kiero/utils/admob_service.dart';
import 'package:kiero/utils/appconstant.dart';
import 'package:kiero/view/settingscreen/settingscreen.dart';

import '../../utils/message.dart';

class MainScreen extends StatelessWidget {
  late MainController model;

  @override
  Widget build(BuildContext context) {
    model = Get.put(MainController());
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;

        if (await model.webViewController?.canGoBack() ?? false) {
          model.webViewController?.goBack();
        } else {
          model.onWillPop(context);
        }
      },

      child: Obx(
        () => FocusDetector(
          onFocusGained: () {
            model.getDarkMode();
          },
          child: Scaffold(
            backgroundColor: model.isDark.isTrue ? Colors.black : Colors.white,
            appBar: enableAppBar
                ? AppBar(
                    backgroundColor:
                        model.isDark.isTrue ? Colors.black : Colors.white,
                    title: Text(
                      homeScreenTitle,
                      style: TextStyle(
                          color: model.isDark.isFalse
                              ? Colors.black
                              : Colors.white),
                    ),
                    iconTheme: IconThemeData(
                        color:
                            model.isDark.isFalse ? Colors.black : Colors.white),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          Get.to(SettingScreen(),transition: Transition.rightToLeft);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(15),
                          child: Icon(Icons.more),
                        ),
                      )
                    ],
                  )
                : null,
            bottomNavigationBar: !enableBannerAds
                //? const SizedBox.shrink()
                ? _bottomNavigationBar(context)
                : SizedBox(
                    height: 50.0,
                    width: double.maxFinite,
                    child: AdWidget(
                        key: UniqueKey(),
                        ad: AdMobService.createBannerAd()..load()),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startDocked,
            floatingActionButton: Visibility(
              visible: enableFloatIcon,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: FloatingActionButton(
                  onPressed: () {
                    //model.onDemoScreenClicked();
                    Get.to(SettingScreen(),transition: Transition.rightToLeft, duration: Duration(seconds: 1));
                  },
                  child: const Icon(Icons.more_vert),
                ),
              ),
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


                /*initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                        useShouldOverrideUrlLoading: true,
                        mediaPlaybackRequiresUserGesture: false,
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
                        allowUniversalAccessFromFileURLs: true),
                    android: AndroidInAppWebViewOptions(
                      thirdPartyCookiesEnabled: true,
                      allowFileAccess: true,
                    ),
                    ios: IOSInAppWebViewOptions(
                      allowsInlineMediaPlayback: true,
                    )),*/
                initialUrlRequest: URLRequest(url: WebUri(mainUrl)),
                onPermissionRequest: (controller, request) async {
                  return PermissionResponse(
                      resources: request.resources,
                      action: PermissionResponseAction.GRANT);
                },
                onWebViewCreated: (controller) async {
                  model.pullToRefreshController.beginRefreshing();
                  model.webViewController = controller;
                },
                onLoadStart: (controller, url) async {
                  model.pullToRefreshController.beginRefreshing();
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  var url = navigationAction.request.url.toString();
                  var uri = Uri.parse(url);

                  if (Platform.isIOS && url.contains("geo")) {
                    url = url.replaceFirst('geo://', 'http://maps.apple.com/');
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
                onReceivedError: (controller, request, error) {
                  model.pullToRefreshController.endRefreshing();
                },
                /*onLoadError: (controller, url, code, message) {
                  model.pullToRefreshController.endRefreshing();
                },*/
                onLoadStop: (controller, url) async {
                  model.pullToRefreshController.endRefreshing();
                },
                onProgressChanged: (controller, progress) {},
                onDownloadStartRequest:
                    (controller, downloadStartRequest) async {
                  // print('=--download--$url');

                  String url = downloadStartRequest.url.toString();
                  try {
                    Dio dio = Dio();
                    String fileName;
                    if (url.toString().lastIndexOf('?') > 0) {
                      fileName = url.toString().substring(
                          url.toString().lastIndexOf('/') + 1,
                          url.toString().lastIndexOf('?'));
                    } else {
                      fileName = url
                          .toString()
                          .substring(url.toString().lastIndexOf('/') + 1);
                    }
                    String savePath = await getFilePath(fileName);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Downloading file..'),
                    ));
                    await dio.download(url.toString(), savePath,
                        onReceiveProgress: (rec, total) {});

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Download Complete'),
                    ));
                  } on Exception catch (_) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Downloading failed'),
                    ));
                  }
                },
                onUpdateVisitedHistory: (controller, url, isReload) {},
                onConsoleMessage: (controller, consoleMessage) {
                  print(consoleMessage);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';
    var externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = '/storage/emulated/0/Download';
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    path = '$externalStorageDirPath/$uniqueFileName';
    return path;
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return SizedBox(
      height: 40.0,
      width: double.maxFinite,
      child:   Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
                onPressed: (){
                  Get.to(SettingScreen(),transition: Transition.rightToLeft);
                },
                icon: Icon(Icons.more_vert)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
                onPressed: (){
                  model.changePage(onSaleUrl, Message.ON_SALES);
                },
                icon: Icon(Icons.discount)
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
                onPressed: (){
                  model.changePage(shoppingCartUrl, Message.SHOPPING_CART);
                },
                icon: Icon(Icons.shopping_cart)
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
                onPressed: (){
                  model.changePage(requestCreditUrl, Message.REQUEST_CREDIT);
                },
                icon: Icon(Icons.attach_money)),

          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
                onPressed: (){
                  model.changePage(loginUrl, Message.LOGIN);
                },
                icon: Icon(Icons.person)),

          ),

          /*Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
                onPressed: (){
                  _onWillPop(context);
                },
                icon: Icon(Icons.logout)),

          ),*/
        ],
      ),
    );
  }



  Future<bool> _onWillPopOld(BuildContext context) async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(Message.ARE_YOU_SURE),
        content: Text(Message.DO_YOU_WANT_TO_EXIT),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Don't exit
            child: Text(Message.NO),
          ),
          TextButton(
            //onPressed: () => Navigator.of(context).pop(true), // Exit
            onPressed: () {
                SystemNavigator.pop() ; // Exit
            },
            child: Text(Message.YES),
          ),
        ],
      ),
    )) ??
        false; // Default to false if dialog is dismissed
  }
}
