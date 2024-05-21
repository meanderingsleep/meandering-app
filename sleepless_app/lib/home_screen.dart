import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sleepless_app/play_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedGender = 'male';
  String? _selectedStory = 'classic';
  bool showEmailForm = true;

  final TextStyle _genderStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16);

  late TextEditingController _textController;

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      showEmailForm = !(prefs.getBool('email_submitted') ?? false);
    });
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('email_submitted', !showEmailForm);
    });
  }

  @override void initState() {
    _textController = TextEditingController();
    _loadPrefs();
    super.initState();
  }

  @override void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title: SvgPicture.asset(
            width: 50,
            height: 50,
            'assets/images/logo.svg',
          ),
            backgroundColor: Colors.transparent
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
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
                Container (
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 3,
                        offset: const Offset(0, -2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 13.0),
                    child: CupertinoSlidingSegmentedControl<String>(
                      key: const Key('genderSlider'),
                      backgroundColor: Colors.white10,
                      // Semi-transparent background
                      thumbColor: Colors.white30,
                      // White thumb for better visibility
                      children: {
                        'male': Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: Text('Male',
                              key: const Key('maleKey'),
                              style: _genderStyle
                          ),
                        ),
                        'female': Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          child: Text('Female',
                            key: const Key('femaleKey'),
                            style: _genderStyle,
                          ),
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
                ),
                Container (
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 3,
                                offset: const Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          child: SvgPicture.asset(
                              'assets/images/buttoncontainer.svg'),
                        ),
                        Column(
                            children: [
                              Container (
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Container (
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 3,
                                        offset: const Offset(0, 6), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: MaterialButton(
                                    padding: const EdgeInsets.all(0.0),
                                    key: const Key('meander'),
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: SvgPicture.asset(
                                      'assets/images/meanderingbutton.svg',
                                    ),
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
                                ),
                              ),
                              Container (
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Container (
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 3,
                                        offset: const Offset(0, 6), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: MaterialButton(
                                    padding: const EdgeInsets.all(0.0),
                                    key: const Key('boring'),
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: SvgPicture.asset(
                                      'assets/images/boringbutton.svg',
                                    ),
                                    onPressed: () {
                                      _selectedStory = 'initialize_boring';
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>
                                            PlayScreen(selectedGender: _selectedGender,
                                                selectedStory: _selectedStory)),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container (
                                child: Container (
                                  // padding: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 3,
                                        offset: const Offset(0, 6), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: MaterialButton(
                                    padding: const EdgeInsets.all(0.0),
                                    key: const Key('port'),
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: SvgPicture.asset(
                                      'assets/images/portbutton.svg',
                                    ),
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
                                ),
                              )
                            ]
                        )
                      ]
                  ),
                ),
          Visibility(visible: showEmailForm, child: Column ( children: [
                      Container (
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('Stay up to date',
                      style: TextStyle(
                        color: Colors.grey.withOpacity(0.9),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat-Bold',
                        fontSize: 18,
                      ),
                  ),
                ),
                Container(
                  width: 290, // Add horizontal padding to the container
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 3,
                        offset: const Offset(0, 10), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 65,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: const BorderRadius.horizontal(left: Radius.circular(15.0)),
                          ),
                          child: Form(
                            key: const Key('email_form'),
                            child: CupertinoTextFormFieldRow(
                              controller: _textController,
                              placeholder: 'Email address',
                              placeholderStyle: const TextStyle(
                                color: Colors.white12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat-Bold',
                              ),
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                              decoration: const BoxDecoration(
                                border: Border(right: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 65,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: const BorderRadius.horizontal(right: Radius.circular(15.0)),
                        ),
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          child: const Opacity(
                            opacity: 0.75,
                            child: Icon(
                              Icons.check_circle_outline_rounded,
                              color: Colors.yellow,
                              size: 28,
                            ),
                          ),
                          onPressed: () async {
                            saveEmail(_textController.text);
                            showEmailForm = false;
                            _savePrefs();
                            Fluttertoast.showToast(
                                msg: 'You have been subscribed.',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey[800],
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
