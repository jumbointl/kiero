import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kiero/controller/settingcontroller.dart';
import 'package:kiero/utils/admob_service.dart';
import 'package:kiero/utils/appconstant.dart';

import '../../utils/message.dart';
import '../common/common_screen.dart';

class SettingScreen extends CommonScreen {
  bool fromMainScreen;

  late SettingController model;
  SettingScreen({required this.fromMainScreen});
  @override
  Widget build(BuildContext context) {
    setControllerModel();
    return Obx(() => Scaffold(
        backgroundColor: model.isDark.value ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor: model.isDark.value ? Colors.black : Colors.white,
          title: Text(Message.SETTING,style: TextStyle(color: !model.isDark.value ? Colors.black : Colors.white),),
          iconTheme: IconThemeData(color: !model.isDark.value ? Colors.black : Colors.white),
        ),
        bottomNavigationBar: !enableBannerAds
            ? const SizedBox.shrink()
            : SizedBox(
                height: 50.0,
                width: double.maxFinite,
                child: AdWidget(
                    key: UniqueKey(), ad: AdMobService.createBannerAd()..load()),
              ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Obx(
                    () => ListTile(
                      title: Text(Message.DARK_MODE,style: TextStyle(color: !model.isDark.value ? Colors.black : Colors.white),),
                      leading: Icon(Icons.dark_mode,color: !model.isDark.value ? Colors.black : Colors.white,),
                      trailing: Switch(
                        value: model.isDark.value,
                        onChanged: (value) {
                          model.setDarkTheme();
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      model.goToContactUsPage(context);

                    },
                    title: Text(Message.CONTACT_US,style: TextStyle(color: !model.isDark.value ? Colors.black : Colors.white),),
                    leading: Icon(Icons.contact_mail_sharp,color: !model.isDark.value ? Colors.black : Colors.white,),
                    trailing: Icon(Icons.chevron_right,color: !model.isDark.value ? Colors.black : Colors.white,),
                  ),
                  ListTile(
                    onTap: () {
                      model.goToAboutUsPage(context);
                    },
                    title: Text(Message.ABOUT_US,style: TextStyle(color: !model.isDark.value ? Colors.black : Colors.white),),
                    leading: Icon(Icons.info_rounded,color: !model.isDark.value ? Colors.black : Colors.white,),
                    trailing: Icon(Icons.chevron_right,color: !model.isDark.value ? Colors.black : Colors.white,),
                  ),
                  //TODO: add in app review
                  /*ListTile(
                    onTap: () {
                      model.inAppReviewClicked(context);

                    },
                    title: Text(Message.RATE_US,style: TextStyle(color: !model.isDark.value ? Colors.black : Colors.white),),
                    leading: Icon(Icons.star,color: !model.isDark.value ? Colors.black : Colors.white,),
                    trailing: Icon(Icons.chevron_right,color: !model.isDark.value ? Colors.black : Colors.white,),
                  ),*/
                  ListTile(
                    onTap: () {
                      model.exitClicked(context);
                    },
                    title: Text(Message.EXIT,style: TextStyle(color: !model.isDark.value ? Colors.black : Colors.white),),
                    leading: Icon(Icons.logout,color: !model.isDark.value ? Colors.black : Colors.white,),
                    trailing: Icon(Icons.chevron_right,color: !model.isDark.value ? Colors.black : Colors.white,),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onItemTapped(BuildContext context, int value) {
  }

  @override
  void setControllerModel() {
    model = Get.put(SettingController());
  }

  @override
  void setPageIndex() {
    pageIndex = PAGE_SETTING;
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
