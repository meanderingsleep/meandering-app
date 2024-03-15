import 'package:flutter/material.dart';
import 'package:sleepless_app/play_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// Here, change StatelessWidget to State<HomeScreen>
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleepless'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Image.asset('assets/images/image.png'),
          onPressed: () {
            // Navigate to the PlayScreen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PlayScreen()),
            );
          },
        ),
      ),
    );
  }
}
