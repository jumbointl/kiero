import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kiero/controller/democontroller.dart';
import 'package:kiero/utils/admob_service.dart';
import 'package:kiero/utils/appconstant.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Get.put(DemoController());
    return FocusDetector(
      onFocusGained: () {
        model.getDarkMode();
      },
      child: Obx(
        () => Scaffold(
          backgroundColor: model.isDark.value ? Colors.black : Colors.white,
          appBar: AppBar(backgroundColor:
          model.isDark.value ? Colors.black : Colors.white,
            title: Text(
              "Demo Screen",
              style: TextStyle(
                  color:
                  !model.isDark.value ? Colors.black : Colors.white),
            ),
            iconTheme: IconThemeData(
                color:
                !model.isDark.value ? Colors.black : Colors.white),
          ),
          bottomNavigationBar: !enableBannerAds
              ? const SizedBox.shrink()
              : SizedBox(
                  height: 50.0,
                  width: double.maxFinite,
                  child: AdWidget(
                      key: UniqueKey(),
                      ad: AdMobService.createBannerAd()..load()),
                ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: model.customUrl,
                    keyboardType: TextInputType.url,
                    style: TextStyle(color: !model.isDark.value ? Colors.black : Colors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Demo Url can't be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter website url',
                      hintStyle: TextStyle(color: !model.isDark.value ? Colors.black : Colors.white),
                      filled: true,
                      fillColor: Colors.black12,
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        model.onCustomUrlClicked(model.customUrl.text,"Custom Link");
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: const Center(
                            child: Text(
                          "Check it out",
                          style: TextStyle(color: Colors.white),
                        )),
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 15),
                    child: Text(
                      "Suggested..",
                      style: TextStyle(color: !model.isDark.value ? Colors.black54 : Colors.white, fontSize: 15),
                    ),
                  ),
                  ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          onTap: () {
                            model.onCustomUrlClicked("https://www.google.com/","Google");
                          },
                          trailing:  Icon(Icons.arrow_forward,color:  !model.isDark.value ? Colors.black : Colors.white,),
                          leading: Image.asset(
                            "assets/images/google.png",
                            height: 30,
                            width: 30,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          tileColor:
                              Colors.greenAccent.shade100.withOpacity(.5),
                          title:  Text("Google",style: TextStyle(color: !model.isDark.value ? Colors.black54 : Colors.white,)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          onTap: () {
                            model
                                .onCustomUrlClicked("https://www.youtube.com/","Youtube");
                          },
                          trailing: Icon(Icons.arrow_forward,color:  !model.isDark.value ? Colors.black : Colors.white,),
                          leading: Image.asset(
                            "assets/images/youtube.png",
                            height: 30,
                            width: 30,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          tileColor: Colors.redAccent.shade100.withOpacity(.5),
                          title: Text("Youtube",style: TextStyle(color: !model.isDark.value ? Colors.black54 : Colors.white,),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          onTap: () {
                            model.onCustomUrlClicked(
                                "https://www.facebook.com/","Facebook");
                          },
                          trailing: Icon(Icons.arrow_forward,color:  !model.isDark.value ? Colors.black : Colors.white,),
                          leading: Image.asset(
                            "assets/images/facebook.png",
                            height: 30,
                            width: 30,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          tileColor: Colors.blueAccent.shade100.withOpacity(.5),
                          title: Text("Facebook",style: TextStyle(color: !model.isDark.value ? Colors.black54 : Colors.white,)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          onTap: () {
                            model.onCustomUrlClicked(
                                "https://www.instagram.com/","Instagram");
                          },
                          leading: Image.asset(
                            "assets/images/instagram.png",
                            height: 30,
                            width: 30,
                          ),
                          trailing: Icon(Icons.arrow_forward,color:  !model.isDark.value ? Colors.black : Colors.white,),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          tileColor:
                              Colors.orangeAccent.shade100.withOpacity(.5),
                          title: Text("Instagram",style: TextStyle(color: !model.isDark.value ? Colors.black54 : Colors.white,)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
