import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "common.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sleepless_app/play_screen.dart';
import 'package:email_validator/email_validator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class CupertinoTextFieldExample extends StatefulWidget {
  const CupertinoTextFieldExample({super.key});

  @override
  State<CupertinoTextFieldExample> createState() =>
      _CupertinoTextFieldExampleState();
}

class _CupertinoTextFieldExampleState extends State<CupertinoTextFieldExample> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: 'initial text');
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoTextField Sample'),
      ),
      child: Center(
        child: CupertinoTextField(
          controller: _textController,
        ),
      ),
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedGender = 'male';
  String? _selectedStory = 'classic';
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: SvgPicture.asset(
            'assets/images/logo.svg',
          ),
          backgroundColor: Colors.transparent
      ),
      child: Container(
        constraints: const BoxConstraints.expand(),
        decoration: screenDecoration,
        child: SafeArea (
          child: SingleChildScrollView (
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 45.0, bottom: 15),
                    child: SvgPicture.asset('assets/images/speakingicon.svg')
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 13.0),
                  child: CupertinoSlidingSegmentedControl<String>(
                    key: const Key('genderSlider'),
                    backgroundColor: Colors.white10,
                    // Semi-transparent background
                    thumbColor: Colors.white30,
                    // White thumb for better visibility
                    children: const {
                      'male': Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Text('Male',
                            key: Key('maleKey'),
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                              color: Colors
                                  .white, // Changed to white for better contrast
                            )),
                      ),
                      'female': Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        child: Text('Female',
                            key: Key('femaleKey'),
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                              color: Colors
                                  .white, // Changed to white for better contrast
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
                Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 20.0),
                        child: SvgPicture.asset(
                            'assets/images/buttoncontainer.svg'),
                      ),
                      Column(
                          children: [
                            CupertinoButton(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 7.0),
                              child: SvgPicture.asset(
                                  'assets/images/meanderingbutton.svg'),
                              onPressed: () {
                                _selectedStory = 'classic';
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      PlayScreen(selectedGender: _selectedGender,
                                          selectedStory: _selectedStory)),
                                );
                              },
                            ),
                            CupertinoButton(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 7.0),
                              child: SvgPicture.asset(
                                  'assets/images/boringbutton.svg'),
                              onPressed: () {
                                _selectedStory = 'boring';
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      PlayScreen(selectedGender: _selectedGender,
                                          selectedStory: _selectedStory)),
                                );
                              },
                            ),
                            CupertinoButton(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 7.0),
                              child: SvgPicture.asset(
                                  'assets/images/portbutton.svg'),
                              onPressed: () {
                                _selectedStory = 'weather';
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      PlayScreen(selectedGender: _selectedGender,
                                          selectedStory: _selectedStory)),
                                );
                              },
                            ),
                          ]
                      )
                    ]
                ),
                Row(
                  children: [
                    Expanded (
                      child: Form(
                        key: formKey,
                        child: CupertinoTextFormFieldRow(
                          placeholder: 'Email',
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Enter a valid email'
                              : null,
                          decoration: BoxDecoration(
                            color: Colors.white, // Set the background color to white
                            border: Border.all(
                              color: Colors.grey, // Optional: Set border color
                              width: 1.0, // Optional: Set border width
                            ),
                            borderRadius: BorderRadius.circular(15.0), // Optional: Set border radius
                          ),
                        ),
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,  // Minimize padding
                      child: Container(
                        width: 40,  // Define a fixed width
                        height: 40,  // Define a fixed height to make it square
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: CupertinoColors.activeBlue,  // Background color
                          borderRadius: BorderRadius.circular(8),  // Rounded corners
                        ),
                        child: Icon(
                          CupertinoIcons.check_mark,  // Icon instead of text
                          size: 28,
                          color: CupertinoColors.white,
                        ),
                      ),
                      onPressed: () {
                        final FormState? form = formKey.currentState;
                        if (form != null && form.validate()) {
                          print('Form Valid');
                        }
                      },
                    )
                  ]
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
