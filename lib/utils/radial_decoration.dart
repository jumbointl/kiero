import 'package:flutter/material.dart';
import 'package:kiero/utils/appconstant.dart';

BoxDecoration radialDecoration() {

  return BoxDecoration(
     color: Colors.purple,
      image: DecorationImage(image: AssetImage(splashScreenBackground),fit: BoxFit.fitHeight,opacity: .7,alignment: Alignment.center),
      gradient: LinearGradient(colors: [
        Color(0xFF87d3f9),
        Color(0xFF62bdf4),
  ]));
}
