import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../utils/admob_service.dart';
import '../utils/appconstant.dart';
import '../utils/message.dart';
import '../utils/preferences.dart';
import '../view/about_us/about_us_screen.dart';
import '../view/contact_us/contact_us_screen.dart';
import '../view/demoscreen/demoscreen.dart';
import '../view/home/home_screen.dart';
import '../view/login/login_screen.dart';
import '../view/on_sale_screen/on_sale_screen.dart';
import '../view/request_credit_screen/request_credit_screen.dart';
import '../view/settingscreen/settingscreen.dart';
import '../view/shopping_cart/shopping_cart_screen.dart';

abstract class ControllerModel extends GetxController{
  InAppWebViewController? webViewController;
  late PullToRefreshController pullToRefreshController;
  RxString url=''.obs;
  RxString title=''.obs;
  var isDark = false.obs;
  RxInt selectedIndex = 4.obs;
  RxBool isLoading = false.obs;
  var transitionType = Transition.fadeIn;
  int transitionMilliseconds = 1800;
  int millisecondsAdjustment = 1500;


  Future<void> getDarkMode() async {
    Preferences preferences = Preferences();
    isDark.value = await preferences.getDarkMode();
  }

  Future<void> setDarkMode(bool value) async {
    Preferences preferences = Preferences();
    await preferences.setDarkMode(value);
  }
  void changeUrl(String url, String title) {
    if(isLoading.value) {
      return;
    }
    try {
      if (Platform.isAndroid) {
        webViewController!.loadUrl(urlRequest: URLRequest(url: WebUri(url)));
      } else if (Platform.isIOS) {
        webViewController!.loadUrl(
            urlRequest: URLRequest(url: WebUri(url)));
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> onWillPop(BuildContext context) async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      borderSide: const BorderSide(
        color: Colors.green,
        width: 2,
      ),
      width: MediaQuery.of(context).size.width * 0.8 > 500 ? 500 : MediaQuery.of(context).size.width * 0.8,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,

      headerAnimationLoop: false,

      animType: AnimType.bottomSlide,
      title: Message.ARE_YOU_SURE,
      desc: Message.DO_YOU_WANT_TO_EXIT,
      showCloseIcon: true,
      btnCancelText: Message.NO,
      btnOkText: Message.YES,
      btnCancelOnPress: () {
      },
      btnOkOnPress: () {
        Navigator.of(context).pop(true);
        //SystemNavigator.pop() ; // Exit
        if (Platform.isAndroid) {
          // call this to exit app
          FlutterExitApp.exitApp();
        } else if (Platform.isIOS) {
          // force exit in ios
          FlutterExitApp.exitApp(iosForceExit: true);
        }
      },
    ).show();
  }
  void exitClicked(BuildContext context) {
    onWillPop(context);
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
  void setDarkTheme() {
    isDark.toggle();
    setDarkMode(isDark.value);
  }
  showAds() {
    if (enableInterstitialAds) {
      AdMobService.createInterstitialAd();
      AdMobService.showInterstitialAd();
    }
  }
  void onDemoScreenClicked() {
    Get.to(DemoScreen(), transition: Transition.leftToRight);
  }
  Future<void> onItemTapped(BuildContext context, int index) async {
    switch(index){
      case 0:
        goToSettingsPage(context);
        break;
      case 1:
        goToHomePage(context);
        break;
      case 2:
        goToOnSalePage(context);
        break;
      case 3:
        goToShoppingCartPage(context);
        break;
      case 4:
        goToRequestCreditPage(context);
        break;
      case 5:
        goToLoginPage(context);
        break;
    }
  }

  void goToAboutUsPage(BuildContext context) {
    Get.to(()=>AboutUsScreen(),
      transition: transitionType , duration: Duration(milliseconds: transitionMilliseconds+millisecondsAdjustment),
    );
  }
  void goToContactUsPage(BuildContext context) {
    Get.to(()=>ContactUsScreen(),
      transition: transitionType , duration: Duration(milliseconds: transitionMilliseconds+millisecondsAdjustment),
    );
  }
  void goToHomePage(BuildContext context) {
    Get.off(()=>HomeScreen(),
      transition: transitionType , duration: Duration(milliseconds: transitionMilliseconds),
    );
  }
  void goToOnSalePage(BuildContext context) {
    Get.to(()=>OnSaleScreen(),
      transition: transitionType , duration: Duration(milliseconds: transitionMilliseconds),
    );
  }
  void goToShoppingCartPage(BuildContext context) {
    Get.to(()=>ShoppingCartScreen(),
      transition: transitionType , duration: Duration(milliseconds: transitionMilliseconds+millisecondsAdjustment),
    );
  }
  void goToRequestCreditPage(BuildContext context) {
    Get.to(()=>RequestCreditScreen(),
      transition: transitionType , duration: Duration(milliseconds: transitionMilliseconds+millisecondsAdjustment),
    );
  }
  void goToLoginPage(BuildContext context) {
    Get.to(()=>LoginScreen(),
      transition: transitionType , duration: Duration(milliseconds: transitionMilliseconds+millisecondsAdjustment),
    );
  }
  void goToSettingsPage(BuildContext context) {
    Get.to(()=>SettingScreen(fromMainScreen: true,),transition: Transition.rightToLeft,
        duration: Duration(seconds: 1));
  }

}