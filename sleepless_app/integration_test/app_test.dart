import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sleepless_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../test/firebase_mock.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseCoreMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

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

    testWidgets('make sure the playback speed and volume dialogs load',
            (tester) async {
          // Load app widget.
          await tester.pumpWidget(const App());

          final meanderButton = find.byKey(const Key('meandering'));
          expect(meanderButton, findsOneWidget);

          // bring up the play screen
          await tester.tap(meanderButton);
          await tester.pumpAndSettle();

          final appBar = find.byKey(const Key('playScreenAppBar'));
          expect(appBar, findsOneWidget);

          // make sure no dialogs are present at first
          var volumeDialog = find.byKey(const Key('volume'));
          expect(volumeDialog, findsNothing);
          var speedDialog = find.byKey(const Key('speed'));
          expect(speedDialog, findsNothing);

          // ensure the volume dialog loads
          final volumeButton = find.byKey(const Key('volumeButton'));
          expect(volumeButton, findsOneWidget);
          await tester.tap(volumeButton);
          await tester.pumpAndSettle();
          volumeDialog = find.byKey(const Key('volume'));
          expect(volumeDialog, findsOneWidget);

          // make the volume dialog disappear
          await tester.tap(appBar, warnIfMissed: false); // tap away from the dialog
          await tester.pumpAndSettle();
          volumeDialog = find.byKey(const Key('volume'));
          expect(volumeDialog, findsNothing);

          // ensure the speed dialog appears
          final speedButton = find.byKey(const Key('speedButton'));
          expect(speedButton, findsOneWidget);
          await tester.tap(speedButton);
          await tester.pumpAndSettle();
          speedDialog = find.byKey(const Key('speed'));
          expect(speedDialog, findsOneWidget);

          // make the volume dialog disappear
          await tester.tap(appBar, warnIfMissed: false); // tap away from the dialog
          await tester.pumpAndSettle();
          speedDialog = find.byKey(const Key('speed'));
          expect(speedDialog, findsNothing);
    });
  });

  group('Authentication tests', () {
    testWidgets('should show error for invalid email format', (tester) async {
      await tester.pumpWidget(const App());
      
      // Navigate to Account screen first
      final accountTab = find.byIcon(Icons.person);
      await tester.tap(accountTab);
      await tester.pumpAndSettle();

      // Find and tap the login button on Account screen
      final loginButton = find.text('Log In');
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Now we're on the login screen, find email field and submit button
      final emailField = find.byKey(const Key('email_field'));
      final submitButton = find.byKey(const Key('submit_button'));

      // Enter invalid email
      await tester.enterText(emailField, 'invalid-email');
      
      // Tap submit and wait for validation
      await tester.tap(submitButton);
      await tester.pump();
      
      // Look for the error message in the SnackBar
      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    testWidgets('should show error for weak password during signup', (tester) async {
      await tester.pumpWidget(const App());
      
      // Navigate to Account screen first
      final accountTab = find.byIcon(Icons.person);
      await tester.tap(accountTab);
      await tester.pumpAndSettle();

      // Find and tap the login button
      final loginButton = find.text('Log In');
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Switch to signup mode
      final switchToSignupButton = find.text('Don\'t have an account? Sign Up');
      await tester.tap(switchToSignupButton);
      await tester.pumpAndSettle();

      // Fill in the form
      await tester.enterText(find.byKey(const Key('email_field')), 'test@example.com');
      await tester.enterText(find.byKey(const Key('password_field')), '123'); // weak password
      await tester.enterText(find.byKey(const Key('confirm_password_field')), '123');

      // Submit form
      await tester.tap(find.byKey(const Key('submit_button')));
      await tester.pumpAndSettle();

      // Verify error message
      expect(find.text('Please enter a stronger password'), findsOneWidget);
    });

    testWidgets('should show error when passwords do not match', (tester) async {
      await tester.pumpWidget(const App());
      
      // Navigate to Account screen first
      final accountTab = find.byIcon(Icons.person);
      await tester.tap(accountTab);
      await tester.pumpAndSettle();

      // Find and tap the login button
      final loginButton = find.text('Log In');
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Switch to signup mode
      final switchToSignupButton = find.text('Don\'t have an account? Sign Up');
      await tester.tap(switchToSignupButton);
      await tester.pumpAndSettle();

      // Now fill in the form with mismatched passwords
      await tester.enterText(find.byKey(const Key('email_field')), 'test@example.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'Password123!');
      await tester.enterText(find.byKey(const Key('confirm_password_field')), 'DifferentPassword123!');

      // Submit form
      await tester.tap(find.byKey(const Key('submit_button')));
      await tester.pumpAndSettle();

      // Verify error message
      expect(find.text('Passwords do not match'), findsOneWidget);
    });
  });
}