import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleepless_app/app_dependencies/app_dependencies.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sleepless_app/home_screen.dart';
import 'package:just_audio_background/just_audio_background.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sleepless',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

Future main() async {
  await dotenv.load();

  runApp(Provider(
    create: (_) => AppDependencies(
      stub: 'test',
      player: AudioPlayer(),
    ),
    child: const App(),
  ));

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  runApp(const App());
}
