import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weatherappv2/Routes/router.dart';
import 'package:firebase_core/firebase_core.dart';

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

    final TextFormField mailField = widgetTester.widget<TextFormField>(find.byKey(const Key('mailFormKey')));
    final TextFormField passwordField = widgetTester.widget<TextFormField>(find.byKey(const Key('passwordFormKey')));

    expect(mailField.controller?.value, null);
    expect(passwordField.controller?.value, null);
    expect(mailField.initialValue, '');
    expect(passwordField.initialValue, '');
  });

  testWidgets(
      "",
      (WidgetTester tester) async {

      }
  );
  
}

typedef Callback = void Function(MethodCall call);

void setupFirebaseAuthMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  setupFirebaseCoreMocks();
}

Future<T> neverEndingFuture<T>() async {
  // ignore: literal_only_boolean_expressions
  while (true) {
    await Future.delayed(const Duration(minutes: 5));
  }
}