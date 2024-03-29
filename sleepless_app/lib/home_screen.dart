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
  String? _selectedGender = 'male';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CupertinoColors.systemPurple, // Start color
              CupertinoColors.systemIndigo, // End color
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 35,
                  height: 35,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: SvgPicture.asset('assets/images/speakingicon.svg')
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 13.0),
                      child: CupertinoSlidingSegmentedControl<String>(
                        key: const Key('genderSlider'),
                        backgroundColor: Colors.white24, // Semi-transparent background
                        thumbColor: Colors.white24, // White thumb for better visibility
                        children: const {
                          'male': Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            child: Text('Male',
                                key: Key('maleKey'),
                                style: TextStyle(
                                  fontSize: 16.0,
                                  decoration: TextDecoration.none,
                                  color: Colors.white, // Changed to white for better contrast
                                )),
                          ),
                          'female': Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                            child: Text('Female',
                                key: Key('femaleKey'),
                                style: TextStyle(
                                  fontSize: 16.0,
                                  decoration: TextDecoration.none,
                                  color: Colors.white, // Changed to white for better contrast
                                )),
                          ),
                        },
                        onValueChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                        groupValue: _selectedGender,
                      ),
                    ),
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: SvgPicture.asset('assets/images/playnightly.svg'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PlayScreen(selectedGender: _selectedGender)),
                        );
                      },
                    ),
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      child: SvgPicture.asset('assets/images/boringweather.svg'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PlayScreen(selectedGender: _selectedGender)),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
