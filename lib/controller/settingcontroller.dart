import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:kiero/controller/controller_model.dart';
import 'package:kiero/utils/admob_service.dart';
import 'package:kiero/utils/appconstant.dart';
import 'package:kiero/view/customscreen/customscreen.dart';

class SettingController extends ControllerModel {

  void setDarkTheme() {
    isDark.toggle();
    setDarkMode(isDark.value);
  }

  void changePage(String url, String title) {
    pageCalledCount++;
    Get.to(CustomScreen(),
        arguments: {"customUrl": url, "title": title},
        transition: pageCalledCount.isEven ? Transition.rightToLeft : Transition.leftToRight,
        duration: Duration(seconds: 1));
  }

  @override
  void onInit() {
    showAds();
    getDarkMode();
    super.onInit();
  }

  showAds() {
    if (enableInterstitialAds) {
      AdMobService.createInterstitialAd();
      AdMobService.showInterstitialAd();
    }
  }



  Future<void> inAppReviewClicked() async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    } else {
      changePage(moreFromUsUrl, "Our Products");
      print("Application not found on playstore");
    }
  }

}
