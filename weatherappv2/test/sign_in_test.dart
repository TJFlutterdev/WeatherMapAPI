import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weatherappv2/Routes/router.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_setup_mock.dart';


void main() {

  setupFirebaseAuthMocks();

  setUp(() async {
    await Firebase.initializeApp();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: MyRouter.initialRoute(),
      onGenerateRoute: MyRouter.generateRoute,
    );
  }

  testWidgets('title is displayed', (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Login'), findsOneWidget);
  });
  
  testWidgets('Mail And Password are Empty and initialed correctly', (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest());

    final TextFormField mailField = widgetTester.widget<TextFormField>(find.byKey(const Key('signInMailFormKey')));
    final TextFormField passwordField = widgetTester.widget<TextFormField>(find.byKey(const Key('signInPasswordFormKey')));

    expect(widgetTester.widget<TextButton>(find.byKey(const Key('signInButtonFormKey'))).enabled, isFalse);
    expect(mailField.initialValue, '');
    expect(passwordField.initialValue, '');
  });

  testWidgets(
      'If Mail and Password are correctly filled, button should be enable if not should be disabled',
          (widgetTester) async {
        await widgetTester.pumpWidget(createWidgetUnderTest());
        var mailField = find.byKey(const Key('signInMailFormKey'));
        var passwordField = find.byKey(const Key('signInPasswordFormKey'));

        await widgetTester.enterText(mailField, 'exemple@gmail.com');
        await widgetTester.pump(const Duration(milliseconds:400));
        expect(find.text('exemple@gmail.com'), findsOneWidget);
        expect(widgetTester.widget<TextButton>(find.byKey(const Key('signInButtonFormKey'))).enabled, isFalse);

        await widgetTester.enterText(passwordField, 'password');
        await widgetTester.pump(const Duration(milliseconds:400));
        expect(find.text('password'), findsOneWidget);
        expect(widgetTester.widget<TextButton>(find.byKey(const Key('signInButtonFormKey'))).enabled, isTrue);

        await widgetTester.enterText(mailField, 'BadMail');
        await widgetTester.pump(const Duration(milliseconds:400));
        expect(find.text('BadMail'), findsOneWidget);
        expect(widgetTester.widget<TextButton>(find.byKey(const Key('signInButtonFormKey'))).enabled, isFalse);

        });
  
}
