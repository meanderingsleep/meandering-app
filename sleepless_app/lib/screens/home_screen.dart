import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sleepless_app/screens/play_screen.dart';
import 'package:email_validator/email_validator.dart';
import '../utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sleepless_app/screens/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedGender = 'male';
  String? _selectedStory = 'meandering';

  final TextStyle _genderStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16);

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
                                    key: const Key('meandering'),
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: SvgPicture.asset(
                                      'assets/images/meanderingbutton.svg',
                                    ),
                                    onPressed: () {
                                      _selectedStory = 'meandering';
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
                                      _selectedStory = 'boring';
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
                              )
                            ]
                        )
                      ]
                  ),
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is Authenticated) {
                      return Container(
                        width: 290,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(SignOutRequested());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white30,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Log Out',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    }
                    return Column(
                      children: [
                        Container(
                          width: 290,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginScreen(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white30,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginScreen(isSignUp: true),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Create Account',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
