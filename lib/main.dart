import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:kiero/firebase_options.dart';
import 'package:kiero/utils/appconstant.dart';
import 'package:kiero/view/splashscreen/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetStorage.init();
  MobileAds.instance.initialize();

  MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(testDeviceIds: [testDevice]));

  await Permission.camera.request();
  await Permission.microphone.request();
  await Permission.manageExternalStorage.request();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  // Step required to send ios push notification
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else {
    print('User declined or has not accepted permission');
  }

  FirebaseMessaging.onMessage.listen((event) {
    try {
      InAppNotification.show(
        onTap: () {},
        child: Card(
          margin: const EdgeInsets.all(15),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            iconColor: Colors.black,
            textColor: Colors.white,
            minVerticalPadding: 10,
            minLeadingWidth: 0,
            tileColor: Colors.white,
            title: Row(
              children: [
                const Icon(Icons.notifications),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    event.notification!.title!,
                  ),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                event.notification!.body!,
                textAlign: TextAlign.justify,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
        context: Get.context!,
      );
    } catch (e) {
      print(e);
    }
  });

  const fatalError = true;
  // Non-async exceptions
  FlutterError.onError = (errorDetails) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };

  runApp(const MyApp());
}

Future<void> _messageHandler(RemoteMessage message) async {
  print(message.data.toString());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    FirebaseAnalyticsObserver observer =
        FirebaseAnalyticsObserver(analytics: analytics);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kiero',
      theme: ThemeData(
        fontFamily: "GoogleSans",
        colorScheme: ColorScheme.fromSeed(seedColor: Color(appThemeColor)),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        fontFamily: "GoogleSans",
        colorScheme: ColorScheme.fromSeed(seedColor: Color(appThemeColor)),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
