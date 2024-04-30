import 'package:sleepless_app/play_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

void main() {

  testWidgets('Play Screen plays', (tester) async {
    await dotenv.load();

    await tester.pumpWidget(PlayScreen(key: UniqueKey()));

    final backButtonFinder = find.byIcon(Icons.arrow_back);

    expect(backButtonFinder, findsOneWidget);
  });
}