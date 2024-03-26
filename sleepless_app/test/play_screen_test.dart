import 'package:flutter/cupertino.dart';
import 'package:sleepless_app/play_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Play Screen plays', (tester) async {
    await tester.pumpWidget(PlayScreen(key: UniqueKey()));

    final mFinder = find.text('Home');

    expect(mFinder, findsOneWidget);
  });
}