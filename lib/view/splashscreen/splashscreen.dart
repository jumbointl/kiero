import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiero/controller/splashcontroller.dart';
import 'package:kiero/utils/appconstant.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Container(
      child: Scaffold(
        backgroundColor: appThemeColor == 0 ? null : Color(appThemeColor),
        body: SafeArea(
          child: Center(
            child: FadeInImage(
              fit: BoxFit.contain,
              image: AssetImage(appIconDemo),
              width: 350,
              height: 350,
              placeholder: AssetImage(appIconDemo),
            ),
          ),
        ),


        /*body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                child: Container(
                  width: 200,
                  height: 200,
                  color: Color(splashSecondaryColor),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                ),
                child: Container(
                  width: 200,
                  height: 200,
                  color: Color(splashSecondaryColor),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .10,
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * .10,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                child: Container(
                  height: 200,
                  decoration: radialDecoration(),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * .90,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(50)),
                child: Container(
                  height: 200,
                  color: Color(splashSecondaryColor),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: MediaQuery.of(context).size.height * .90,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(50)),
                child: Container(
                  color: Color(splashSecondaryColor),
                ),
              ),
            ),
            *//*Center(
              child: Image.asset(
                appIcon,
                width: 200,
                height: 200,
                color: appIconColor == 0 ? null : Color(appIconColor),
              ),
            ),*//*
            Center(
              child: FadeInImage(
                fit: BoxFit.contain,
                repeat: ImageRepeat.repeat,
                image: AssetImage(appIcon),
                width: 350,
                height: 350,
                color: appIconColor == 0 ? null : Color(appIconColor),
                placeholder: AssetImage(appIcon),
              ))
          ],
        ),*/
      ),
    );
  }
}
