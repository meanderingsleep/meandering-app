import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'common.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sleepless_app/play_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedGender = 'male';
  String? _selectedStory = 'classic';
  final formKey = GlobalKey<FormState>();
  late TextEditingController _textController;

  @override void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override void dispose() {
    _textController.dispose();
    super.dispose();
  }

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
                    padding: const EdgeInsets.only(top: 45.0, bottom: 15),
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
                              padding: const EdgeInsets.only(
                                  top: 13.0, bottom: 4.0),
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
                                  horizontal: 25.0, vertical: 5.0),
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
                                  horizontal: 25.0, vertical: 5.0),
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
                Container (
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Stay up to date",
                      style: TextStyle(
                        color: Colors.grey.withOpacity(0.9),
                        fontWeight: FontWeight.bold,// Set the opacity of the color
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50.0), // Add horizontal padding to the container
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 65, // Specify the height to make it consistent
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.6), // 50% transparent white
                            borderRadius: BorderRadius.horizontal(left: Radius.circular(15.0)),
                            border: Border.all(color: Colors.grey.withOpacity(0.75), width: 1.0), // 50% transparent grey border
                          ),
                          child: Form(
                            key: formKey,
                            child: CupertinoTextFormFieldRow(
                              controller: _textController,
                              placeholder: 'Email',
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                              decoration: const BoxDecoration(
                                border: Border(right: BorderSide.none), // Ensure there's no border on the right
                              ),
                            ),
                          ),
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Container(
                          width: 70, // Adjust width as needed
                          height: 65, // Ensure the button is the same height as the input field
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey.withOpacity(0.6), // 50% transparent blue
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(15.0)),
                          ),
                          child: const Opacity(
                            opacity: 0.75,
                            child: Icon(
                              CupertinoIcons.checkmark_alt_circle_fill,
                              color: Colors.yellow,
                              size: 28,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          final FormState? form = formKey.currentState;
                          if (form != null && form.validate()) {
                            saveEmail(_textController.text);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
