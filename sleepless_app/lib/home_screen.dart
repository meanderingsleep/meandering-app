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
              CupertinoColors.systemIndigo, // Start color
              Colors.blue, // End color
            ],
          ),
        ),
        child: SafeArea(
          // Ensures that content is not obscured by the notch or the status bar
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0), // Adjust padding as needed
                child: SvgPicture.asset(
                  'assets/images/logo.svg', // Your logo's asset path
                  width: 35, // Set your logo's width
                  height: 35, // Set your logo's height
                ),
              ),
              Expanded(
                child: Column(
                  // Wrap your content in another Column widget
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CupertinoSlidingSegmentedControl<String>(
                      key: const Key('genderSlider'),
                      children: const {
                        'male': Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          child: Text('Male',
                              key: Key('maleKey'),
                              style: TextStyle(
                                fontSize: 16.0,
                                decoration: TextDecoration.none,
                                color: Colors.grey, // This ensures no underline
                              )),
                        ),
                        'female': Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          child: Text('Female',
                              key: Key('femaleKey'),
                              style: TextStyle(
                                fontSize: 16.0,
                                decoration: TextDecoration.none,
                                color: Colors.grey, // This ensures no underline
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
                    CupertinoButton(
                      child: SvgPicture.asset('assets/images/playnightly.svg'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PlayScreen()),
                        );
                      },
                    ),
                  ], // Children
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } // Build
} // Class end
