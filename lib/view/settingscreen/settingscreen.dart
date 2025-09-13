import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kiero/controller/settingcontroller.dart';
import 'package:kiero/utils/admob_service.dart';
import 'package:kiero/utils/appconstant.dart';

import '../../utils/message.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final model = Get.put(SettingController());
    return Obx(() => Scaffold(
        backgroundColor: model.isDark.isTrue ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor: model.isDark.isTrue ? Colors.black : Colors.white,
          title: Text(Message.SETTING,style: TextStyle(color: model.isDark.isFalse ? Colors.black : Colors.white),),
          iconTheme: IconThemeData(color: model.isDark.isFalse ? Colors.black : Colors.white),
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
                      title: Text(Message.DARK_MODE,style: TextStyle(color: model.isDark.isFalse ? Colors.black : Colors.white),),
                      leading: Icon(Icons.dark_mode,color: model.isDark.isFalse ? Colors.black : Colors.white,),
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
                      model.changePage(contactUsUrl, Message.CONTACT_US);
                    },
                    title: Text(Message.CONTACT_US,style: TextStyle(color: model.isDark.isFalse ? Colors.black : Colors.white),),
                    leading: Icon(Icons.contact_mail_sharp,color: model.isDark.isFalse ? Colors.black : Colors.white,),
                    trailing: Icon(Icons.chevron_right,color: model.isDark.isFalse ? Colors.black : Colors.white,),
                  ),
                  ListTile(
                    onTap: () {
                      model.changePage(aboutUsUrl, Message.ABOUT_US);
                    },
                    title: Text(Message.ABOUT_US,style: TextStyle(color: model.isDark.isFalse ? Colors.black : Colors.white),),
                    leading: Icon(Icons.info_rounded,color: model.isDark.isFalse ? Colors.black : Colors.white,),
                    trailing: Icon(Icons.chevron_right,color: model.isDark.isFalse ? Colors.black : Colors.white,),
                  ),
            
                  ListTile(
                    onTap: () {
                      model.inAppReviewClicked();
                    },
                    title: Text(Message.RATE_US,style: TextStyle(color: model.isDark.isFalse ? Colors.black : Colors.white),),
                    leading: Icon(Icons.star,color: model.isDark.isFalse ? Colors.black : Colors.white,),
                    trailing: Icon(Icons.chevron_right,color: model.isDark.isFalse ? Colors.black : Colors.white,),
                  ),
                  ListTile(
                    onTap: () {
                      model.exitClicked(context);
                    },
                    title: Text(Message.EXIT,style: TextStyle(color: model.isDark.isFalse ? Colors.black : Colors.white),),
                    leading: Icon(Icons.logout,color: model.isDark.isFalse ? Colors.black : Colors.white,),
                    trailing: Icon(Icons.chevron_right,color: model.isDark.isFalse ? Colors.black : Colors.white,),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
