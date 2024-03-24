import 'package:flutter/material.dart';
import 'package:sleepless_app/home_screen.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  bool isPlaying = false;
  late final AudioPlayer player;

  final String audioUrl = 'https://sleeplesslv.s3.us-east-2.amazonaws.com/sleepless-2024-02-24.mp3';

  Duration _duration = const Duration();
  Duration _position = const Duration();

  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future initPlayer() async {
    player = AudioPlayer();

    // set a callback for changing duration
    player.onDurationChanged.listen((Duration d) {
      setState(() => _duration = d);
    });

    // set a callback for position change
    player.onPositionChanged.listen((Duration p) {
      setState(() => _position = p);
    });

    // set a callback for when audio ends
    player.onPlayerComplete.listen((_) {
      setState(() => isPlaying = false);
    });
  }

  void playPause() async {
    if (isPlaying) {
      player.pause();
      isPlaying = false;
    } else {
      await player.play(UrlSource(audioUrl));
      isPlaying = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Home'),
              onPressed: () {
                // Navigate to the PlayScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            const SizedBox(height: 50),
            Slider(
              value: _position.inSeconds.toDouble(),
              onChanged: (value) async {
                await player.seek(Duration(seconds: value.toInt()));
                setState(() {});
              },
              min: 0,
              max: _duration.inSeconds.toDouble(),
              inactiveColor: Colors.grey,
              activeColor: Colors.deepPurple,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(_duration.toString().substring(0, _duration.toString().indexOf('.'))),
              ],
            ),
            const SizedBox(height: 25),
            Text(
              audioUrl.substring(audioUrl.lastIndexOf('/') + 1),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontFamily: 'Roboto',
                letterSpacing: 0.5,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    player.seek(Duration(seconds: _position.inSeconds - 10));
                    setState(() {});
                  },
                  child: Image.asset('assets/icons/rewind.png'),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: playPause,
                  child: Icon(
                    isPlaying ? Icons.pause_circle : Icons.play_circle,
                    color: Colors.deepPurple,
                    size: 100,
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    player.seek(Duration(seconds: _position.inSeconds + 10));
                    setState(() {});
                  },
                  child: Image.asset('assets/icons/forward.png'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
