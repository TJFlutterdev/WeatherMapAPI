import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';
import 'package:weatherappv2/Models/weather.dart';
import 'package:weatherappv2/Notifier/weather_change_notifier.dart';
import 'package:weatherappv2/Pages/weather_list.dart';
import 'package:weatherappv2/Services/weather_service.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_setup_mock.dart';


class MockWeatherService extends Mock implements WeatherService {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {

  @override
  MockUser? get currentUser => MockUser();

}

class MockUser extends Mock implements User {

  @override
  String? get displayName => 'Tjouin';

}

void main() {
  late MockWeatherService mockWeatherService;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUser mockUser;

  setupFirebaseAuthMocks();

  setUp(() async {
    await Firebase.initializeApp();
    mockWeatherService = MockWeatherService();
    mockFirebaseAuth = MockFirebaseAuth();
    mockUser = mockFirebaseAuth.currentUser!;
  });

  final List<Weather> weatherFromService = [
    Weather(temp: 17,
        description: 'description 1',
        dateTime: DateTime.now(),
        weatherIconHttp: 'http://openweathermap.org/img/wn/01d@2x.png'),
    Weather(temp: 18,
        description: 'description 2',
        dateTime: DateTime.now(),
        weatherIconHttp: 'http://openweathermap.org/img/wn/02d@2x.png'),
    Weather(temp: 19,
        description: 'description 3',
        dateTime: DateTime.now(),
        weatherIconHttp: 'http://openweathermap.org/img/wn/03d@2x.png'),
    Weather(temp: 20,
        description: 'description 4',
        dateTime: DateTime.now(),
        weatherIconHttp: 'http://openweathermap.org/img/wn/04d@2x.png'),
    Weather(temp: 21,
        description: 'description 5',
        dateTime: DateTime.now(),
        weatherIconHttp: 'http://openweathermap.org/img/wn/05d@2x.png'),
  ];

  void arrangeWeatherServiceReturns5Weathers() {
    when(() => mockWeatherService.getWeathers()).thenAnswer(
          (_) async {
        return weatherFromService;
      },
    );
  }

  void arrangeWeatherServiceReturns5WeathersAfter2SecondWait() {
    when(() => mockWeatherService.getWeathers()).thenAnswer(
          (_) async {
        await Future.delayed(const Duration(seconds: 2));
        return weatherFromService;
      },
    );
  }

  Widget createWidgetUnderTest() {
    return MaterialApp(
        title: 'Weather App',
        home: ChangeNotifierProvider(
          create: (_) => WeatherChangeNotifier(mockWeatherService),
          child: WeatherList(currentUser: mockUser),
        )
    );
  }

  testWidgets(
      'Checking if user name is well setup',
          (WidgetTester tester) async {
        arrangeWeatherServiceReturns5Weathers();
        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.text('Tjouin'), findsOneWidget);
      });

  testWidgets(
    "Loading indicator is displayed while waiting for weathers",
        (WidgetTester tester) async {
      await mockNetworkImages(() async {
        arrangeWeatherServiceReturns5WeathersAfter2SecondWait();

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump(const Duration(milliseconds: 500));

        expect(find.byKey(const Key('WeatherListProgressIndicator')),
            findsOneWidget);

        await tester.pump(const Duration(seconds: 3));
      });
    }
    ,
  );
}