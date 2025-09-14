

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/admob_service.dart';
import '../../utils/appconstant.dart';
import '../../utils/message.dart';
import '../settingscreen/settingscreen.dart';

abstract class CommonScreen extends StatelessWidget {
  int pageIndex = 0;


  String? url;
  String? title;
  late int currentIndex ;

  CommonScreen({
    this.url,
    this.title,
  });


  @override
  Widget build(BuildContext context) {
    print('build');
    print('url $url');
    setControllerModel();
    setPageIndex();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;

        if (await webViewController?.canGoBack() ?? false) {
          webViewController?.goBack();
        } else {
          onWillPop(context);
        }
      },

      child: Obx(
            () => FocusDetector(
          onFocusGained: () {
            getDarkMode();
          },
          child: Scaffold(
            backgroundColor: isDark.value ? Colors.black : Colors.white,
            appBar: enableAppBar
                ? AppBar(
              backgroundColor:
              isDark.value ? Colors.black : Colors.white,
              title: Text(
                homeScreenTitle,
                style: TextStyle(
                    color: !isDark.value
                        ? Colors.black
                        : Colors.white),
              ),
              iconTheme: IconThemeData(
                  color:
                  !isDark.value ? Colors.black : Colors.white),
              actions: [
                GestureDetector(
                  onTap: () {
                    Get.to(SettingScreen(fromMainScreen: true,),transition: Transition.rightToLeft);
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
                ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading.value)
                  const LinearProgressIndicator(
                    color: Colors.green,
                    backgroundColor: Colors.white,
                    minHeight: 10, // Adjust height as needed
                  ),
                bottomNavigationBar(context),
              ],
            )
                : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    height: 50.0,
                    width: double.maxFinite,
                    child: AdWidget(key: UniqueKey(), ad: AdMobService.createBannerAd()..load())),
              ],),
            body: SafeArea(
              child: InAppWebView(
                pullToRefreshController: pullToRefreshController,
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

                initialUrlRequest: URLRequest(url: WebUri(url ?? mainUrl)),
                onPermissionRequest: (controller, request) async {
                  return PermissionResponse(
                      resources: request.resources,
                      action: PermissionResponseAction.GRANT);
                },
                onWebViewCreated: (controller) async {
                  pullToRefreshController.beginRefreshing();
                  setWebViewController(controller) ;
                },
                onLoadStart: (controller, url) async {
                  pullToRefreshController.beginRefreshing();
                  isLoading.value = true;
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
                  pullToRefreshController.endRefreshing();
                  isLoading.value = false;
                },
                onLoadStop: (controller, url) async {
                  pullToRefreshController.endRefreshing();
                  isLoading.value = false;
                },
                onProgressChanged: (controller, progress) {},
                onDownloadStartRequest:
                    (controller, downloadStartRequest) async {
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
  Color getBottomNavigationBarBackgroundColor() {
     return isDark.value ? Colors.black :Colors.blue[800]!;
  }
  Widget bottomNavigationBar(BuildContext context) {
    Color iconColor =  Colors.white;
    Color backgroundColor =  getBottomNavigationBarBackgroundColor();

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: backgroundColor ,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.more_vert,color: iconColor), label: Message.MORE),
        BottomNavigationBarItem(icon: Icon(Icons.home,color: iconColor), label: Message.HOME),
        BottomNavigationBarItem(icon: Icon(Icons.discount,color: iconColor), label: Message.ON_SALES),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart,color: iconColor), label: Message.SHOPPING_CART),
        BottomNavigationBarItem(icon: Icon(Icons.attach_money,color: iconColor), label: Message.REQUEST_CREDIT),
        BottomNavigationBarItem(icon: Icon(Icons.person,color: iconColor), label: Message.LOGIN),

      ],
      currentIndex: selectedIndex.value,
      selectedItemColor: Colors.purple[800],
      onTap: (index) => onItemTapped(context, index),
    );
  }

  Future<void> showAutoCloseMessage(BuildContext context,String title,String message,int milliseconds) async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      borderSide: const BorderSide(
        color: Colors.green,
        width: 2,
      ),
      width: MediaQuery.of(context).size.width * 0.9 > 500 ? 500 : MediaQuery.of(context).size.width * 0.9,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      autoDismiss: true,
      autoHide: Duration(milliseconds: milliseconds),
      headerAnimationLoop: false,

      animType: AnimType.bottomSlide,
      title: title,
      desc: message,
      showCloseIcon: true,
      btnOkText: Message.OK,
      btnOkOnPress: () {
        Navigator.of(context).pop(true);
      },
    ).show();
  }
  void onItemTapped(BuildContext context, int index);
  /*void onItemTapped(BuildContext context, int index) {
    print('onItemTapped $index');
    if (isLoading.value) return;
    selectedIndex.value = index;
    currentIndex = selectedIndex.value;

    model.onItemTapped(context, index);

  }*/
  //fill with each controller
  void setWebViewController(InAppWebViewController controller);
  InAppWebViewController? get webViewController;
  PullToRefreshController get pullToRefreshController;
  RxBool get isLoading;
  RxBool get isDark;
  RxInt get selectedIndex ;
  void setControllerModel() ;
  void setPageIndex() ;
  void onWillPop(BuildContext context);
  void getDarkMode() ;
  
}