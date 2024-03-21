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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CupertinoColors.systemIndigo, // Start color
              Colors.blue, // End color
            ],
          ),
        ),
        child: SafeArea( // Ensures that content is not obscured by the notch or the status bar
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 60.0), // Adjust padding as needed
                child: SvgPicture.asset(
                  'assets/images/logo.svg', // Your logo's asset path
                  width: 35, // Set your logo's width
                  height: 35, // Set your logo's height
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoSlidingSegmentedControl<String>(
                  children: {
                    'male': Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      child: Text('Male',
                      style: TextStyle(
                        fontSize: 16.0,
                        decoration: TextDecoration.none,
                        color: Colors.grey, // This ensures no underline
                      )),
                    ),
                    'female': Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      child: Text('Female',
                      style: TextStyle(
                        fontSize: 16.0,
                        decoration: TextDecoration.none,
                        color: Colors.grey, // This ensures no underline
                        // This ensures no underline
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
        ),
      ),
    );
  }
}
