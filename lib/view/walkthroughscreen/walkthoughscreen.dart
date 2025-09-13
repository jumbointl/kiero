import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:kiero/controller/walkthroghcontroller.dart';
import 'package:kiero/utils/appconstant.dart';
import 'package:kiero/utils/radial_decoration.dart';

class WalkThoughScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Get.put(WalkThroughController());
    return Scaffold(
      backgroundColor: Color(walkthroughBackgroundColor),
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(50)),
                child: Container(
                  width: 200,
                  height: 300,
                  decoration: radialDecoration(),
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
                  height: 500,
                  decoration: radialDecoration(),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .15,
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * .20,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                child: Container(
                  height: 200,
                  color: Color(walkthroughBackgroundColor),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * .85,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(50)),
                child: Container(
                  height: 200,
                  decoration: radialDecoration(),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: MediaQuery.of(context).size.height * .80,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(50)),
                child: Container(
                  decoration: radialDecoration(),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .15,
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * .20,
              child: PageView(
                controller: model.pageController,
                onPageChanged: (value) {
                  model.selectedPage.value = value;
                },
                children: [
                  pageOne(),
                  pageTwo(),
                  pageThree(),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * .08,
              child: GestureDetector(
                onTap: () {
                  model.changePage();
                },
                child: const Icon(
                  Icons.arrow_circle_right_rounded,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * .05,
              child: Obx(
                () => PageViewDotIndicator(
                  size: const Size(10, 10),
                  currentItem: model.selectedPage.value,
                  count: 3,
                  unselectedColor: Colors.black45,
                  selectedColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pageOne() {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            walkThroughPageOneTitle,
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Image.asset(walkthroughImage1,height: 250,),
          Text(
            walkThroughPageOneSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget pageTwo() {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            walkThroughPageTwoTitle,
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Image.asset(walkthroughImage2,height: 250,),
          SizedBox(
            height: 10,
          ),
          Text(
            walkThroughPageTwoSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget pageThree() {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            walkThroughPageThreeTitle,
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Image.asset(walkthroughImage3,height: 250,),
          SizedBox(
            height: 10,
          ),
          Text(
            walkThroughPageThreeSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
