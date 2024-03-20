import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sleepless_app/play_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemIndigo,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Aligns the logo to the top of the screen
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 60.0), // Adjust the padding as needed
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/logo.svg', // Your logo's asset path
                    width: 35, // Set your logo's width
                    height: 35, // Set your logo's height
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: CupertinoButton(
                    child: SvgPicture.asset('assets/images/playnightly.svg'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PlayScreen()),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
