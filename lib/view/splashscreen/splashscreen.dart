import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiero/controller/splashcontroller.dart';
import 'package:kiero/utils/appconstant.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double size = MediaQuery.of(context).size.width;

    if (height > width) {
       size = width*0.9;
    } else {
      size = height*0.9;
    }
    Get.put(SplashController());
    return Container(
      child: Scaffold(
        //backgroundColor: appThemeColor == 0 ? null : Color(appThemeColor),
        backgroundColor: Colors.cyan[200],
        body: SafeArea(
          child: Center(
            child: Image(
              fit: BoxFit.contain,
              image: AssetImage(appIcon),
              width: size,
              height: size,
              //placeholder: AssetImage(appIcon),
            ),
          ),
        ),
      ),
    );
  }
}
