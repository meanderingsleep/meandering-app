import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sleepless_app/play_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_shadow/simple_shadow.dart';


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
                Padding(
                  padding: const EdgeInsets.only(bottom: 13.0),
                  child: SimpleShadow (
                    opacity: 0.4,         // Default: 0.5
                    color: Color(0xFF111111),   // Default: Black
                    offset: Offset(0, 7), // Default: Offset(2, 2)
                    sigma: 3,
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
                  )
                ),
                Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 20.0),
                        child: SimpleShadow (
                          opacity: 0.4,         // Default: 0.5
                          color: Color(0xFF111111),   // Default: Black
                          offset: Offset(0, 7), // Default: Offset(2, 2)
                          sigma: 3,
                          child: SvgPicture.asset(
                              'assets/images/buttoncontainer.svg')
                        ),
                      ),
                      Column(
                          children: [
                            MaterialButton(
                              key: const Key('meander'),
                              padding: const EdgeInsets.only(top: 13.0, bottom: 4.0),
                              child: SimpleShadow (
                                  opacity: 0.4,         // Default: 0.5
                                  color: Color(0xFF111111),   // Default: Black
                                  offset: Offset(0, 7), // Default: Offset(2, 2)
                                  sigma: 3,
                                  child: SvgPicture.asset(
                                      'assets/images/meanderingbutton.svg')
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
                            MaterialButton(
                              key: const Key('boring'),
                              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
                              child: SimpleShadow (
                                  opacity: 0.4,         // Default: 0.5
                                  color: Color(0xFF111111),   // Default: Black
                                  offset: Offset(0, 7), // Default: Offset(2, 2)
                                  sigma: 3,
                                  child: SvgPicture.asset(
                                      'assets/images/boringbutton.svg')
                              ),
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
                            MaterialButton(
                              key: const Key('port'),
                              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
                              child: SimpleShadow (
                                  opacity: 0.4,         // Default: 0.5
                                  color: Color(0xFF111111),   // Default: Black
                                  offset: Offset(0, 7), // Default: Offset(2, 2)
                                  sigma: 3,
                                  child: SvgPicture.asset(
                                      'assets/images/portbutton.svg')
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
                          ]
                      )
                    ]
                ),
          Visibility(visible: showEmailForm, child: Column ( children: [
                      Container (
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('Stay up to date',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat-Bold',
                        fontSize: 18,
                      ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 51.0), // Add horizontal padding to the container
                  child: SimpleShadow (
                    opacity: 0.4,         // Default: 0.5
                    color: Color(0xFF111111),   // Default: Black
                    offset: Offset(0, 7), // Default: Offset(2, 2)
                    sigma: 3,
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
                                placeholder: 'Email',
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
                                  msg: "You have been subscribed.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
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
