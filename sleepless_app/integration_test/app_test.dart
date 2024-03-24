import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sleepless_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the female gender button, verify selected',
            (tester) async {
          // Load app widget.
          await tester.pumpWidget(const App());

          final genderSlider = find.byKey(const Key('genderSlider'));
          expect(genderSlider, findsOneWidget);

          expect(tester.widget<CupertinoSlidingSegmentedControl>(genderSlider).groupValue, 'male');

          final femaleButton = find.byKey(const Key('femaleKey'));
          await tester.tap(femaleButton);

          // Trigger a frame.
          await tester.pumpAndSettle();

          // Verify the state changed.
          expect(tester.widget<CupertinoSlidingSegmentedControl>(genderSlider).groupValue, 'female');
        });
  });
}