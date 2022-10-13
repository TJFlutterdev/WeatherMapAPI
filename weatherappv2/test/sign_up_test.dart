import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:weatherappv2/Pages/sign_up.dart';

import 'firebase_setup_mock.dart';


void main() {

  setupFirebaseAuthMocks();

  setUp(() async {
    await Firebase.initializeApp();
  });

  Widget createWidgetUnderTest() {
    return const MaterialApp(
      title: 'Weather App',
      home: SignUp(),
    );
  }

  testWidgets('title is displayed', (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Inscription'), findsOneWidget);
  });

  testWidgets(
      'Mail, Password And Username are Empty and initialed correctly',
          (widgetTester) async {
        await widgetTester.pumpWidget(createWidgetUnderTest());

        final TextButton signUpButton = widgetTester.widget<TextButton>(find.byKey(const Key('signUpButtonFormKey')));
        final TextFormField mailField = widgetTester.widget<TextFormField>(find.byKey(const Key('signUpMailFormKey')));
        final TextFormField passwordField = widgetTester.widget<TextFormField>(find.byKey(const Key('signUpPasswordFormKey')));
        final TextFormField usernameField = widgetTester.widget<TextFormField>(find.byKey(const Key('signUpUsernameFormKey')));

        expect(signUpButton.enabled, false);

        expect(mailField.initialValue, '');
        expect(passwordField.initialValue, '');
        expect(usernameField.initialValue, '');
      });

  testWidgets(
      'If Username, Mail and Password are correctly filled, button should be enable if not should be disabled',
          (widgetTester) async {
            await widgetTester.pumpWidget(createWidgetUnderTest());
            var usernameField = find.byKey(const Key('signUpUsernameFormKey'));
            var mailField = find.byKey(const Key('signUpMailFormKey'));
            var passwordField = find.byKey(const Key('signUpPasswordFormKey'));

            await widgetTester.enterText(usernameField, 'username');
            await widgetTester.pump(const Duration(milliseconds:400));
            expect(find.text('username'), findsOneWidget);
            expect(widgetTester.widget<TextButton>(find.byKey(const Key('signUpButtonFormKey'))).enabled, isFalse);

            await widgetTester.enterText(mailField, 'exemple@gmail.com');
            await widgetTester.pump(const Duration(milliseconds:400));
            expect(find.text('exemple@gmail.com'), findsOneWidget);
            expect(widgetTester.widget<TextButton>(find.byKey(const Key('signUpButtonFormKey'))).enabled, isFalse);

            await widgetTester.enterText(passwordField, 'password');
            await widgetTester.pump(const Duration(milliseconds:400));
            expect(find.text('password'), findsOneWidget);
            expect(widgetTester.widget<TextButton>(find.byKey(const Key('signUpButtonFormKey'))).enabled, isTrue);

            await widgetTester.enterText(mailField, 'BadMail');
            await widgetTester.pump(const Duration(milliseconds:400));
            expect(find.text('BadMail'), findsOneWidget);
            expect(widgetTester.widget<TextButton>(find.byKey(const Key('signUpButtonFormKey'))).enabled, isFalse);
      });



}