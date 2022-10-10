// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weatherappv2/Models/Weather.dart';
import 'package:weatherappv2/Notifier/WeatherChangeNotifier.dart';
import 'package:weatherappv2/Services/weather_service.dart';

class MockWeatherService extends Mock implements WeatherService {}

void main() {
  late WeatherChangeNotifier sut ;
  late MockWeatherService mockWeatherService;

  setUp(() {
    mockWeatherService = MockWeatherService();
    sut = WeatherChangeNotifier(mockWeatherService);
  });
  
  test('Initial value test',
          () {
    expect(sut.weathers, []);
    expect(sut.isLoading, false);
  });

  group('getWeathers', () {

    List<Weather> weatherFromService = [
      Weather(temp: 17,description: 'description 1', dateTime: DateTime.now(), weatherIconHttp:'http://openweathermap.org/img/wn/01d@2x.png'),
      Weather(temp: 18,description: 'description 2', dateTime: DateTime.now(), weatherIconHttp:'http://openweathermap.org/img/wn/02d@2x.png'),
      Weather(temp: 19,description: 'description 3', dateTime: DateTime.now(), weatherIconHttp:'http://openweathermap.org/img/wn/03d@2x.png'),
      Weather(temp: 20,description: 'description 4', dateTime: DateTime.now(), weatherIconHttp:'http://openweathermap.org/img/wn/04d@2x.png'),
      Weather(temp: 21,description: 'description 5', dateTime: DateTime.now(), weatherIconHttp:'http://openweathermap.org/img/wn/05d@2x.png'),
    ];

    void arrangeWeatherServiceReturnWeathers() {
      when(() => mockWeatherService.getWeathers()).thenAnswer((_) async => weatherFromService);
    }

    test('get Weather by WeatherService', () async {
      arrangeWeatherServiceReturnWeathers();
      await sut.getWeathers();
      verify(() => mockWeatherService.getWeathers()).called(1);
    });

    test('indicate loading of data, set data correctly, stop loading', () async {
      arrangeWeatherServiceReturnWeathers();
      final future = sut.getWeathers();
      expect(sut.isLoading, true);
      await future;
      expect(sut.weathers, weatherFromService);
      expect(sut.isLoading, false);
    });

  });
  
}
