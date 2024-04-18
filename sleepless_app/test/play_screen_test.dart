import 'package:flutter/cupertino.dart';
import 'package:sleepless_app/play_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {

  testWidgets('Play Screen plays', (tester) async {
    await dotenv.load();

    await tester.pumpWidget(PlayScreen(key: UniqueKey()));

    final mFinder = find.text('Home');

    expect(mFinder, findsOneWidget);
  });
}