import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sleepless_app/home_screen.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'common.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    const textStyleDefault = TextStyle(
      fontFamily: 'Montserrat',
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16.0,
    );

    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Sleepless',
      theme: CupertinoThemeData(
        scaffoldBackgroundColor: backgroundColor,
        textTheme: CupertinoTextThemeData(
          textStyle: textStyleDefault,
          actionTextStyle: textStyleDefault,
          tabLabelTextStyle: textStyleDefault,
          navActionTextStyle: textStyleDefault,
          navTitleTextStyle: textStyleDefault,
          navLargeTitleTextStyle: textStyleDefault,
          pickerTextStyle: textStyleDefault,
          dateTimePickerTextStyle: textStyleDefault,
        )
      ),
      home: HomeScreen(),
    );
  }
}

Future main() async {
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const App());
}
