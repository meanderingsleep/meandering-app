import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleepless_app/app_dependencies/app_dependencies.dart';

import 'package:sleepless_app/home_screen.dart';

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

void main() {
  runApp(Provider(
    create: (_) => AppDependencies(stub: 'test'),
    child: const App(),
  ));

  runApp(const App());
}
