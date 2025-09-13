import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/message.dart';
import '../utils/preferences.dart';
import '../view/customscreen/customscreen.dart';

class ControllerModel extends GetxController{
  var isDark = false.obs;
  Future<void> getDarkMode() async {
    Preferences preferences = Preferences();
    isDark.value = await preferences.getDarkMode();
  }

  Future<void> setDarkMode(bool value) async {
    Preferences preferences = Preferences();
    await preferences.setDarkMode(value);
  }
  void changePage(String url, String title) {
    Get.to(CustomScreen(),
        arguments: {"customUrl": url, "title": title},
        transition: Transition.downToUp ,duration: Duration(milliseconds: 1500));
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
      /*onDismissCallback: (type) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Dismissed by $type'),
          ),
        );
      },*/
      headerAnimationLoop: false,

      animType: AnimType.bottomSlide,
      title: Message.ARE_YOU_SURE,
      desc: Message.DO_YOU_WANT_TO_EXIT,
      showCloseIcon: true,
      btnCancelText: Message.NO,
      btnOkText: Message.YES,
      btnCancelOnPress: () {
        //Navigator.of(context).pop(false);
      },
      btnOkOnPress: () {
        Navigator.of(context).pop(true);
        SystemNavigator.pop() ; // Exit

      },
    ).show();
  }
  void exitClicked(BuildContext context) {
    onWillPop(context);
  }
}