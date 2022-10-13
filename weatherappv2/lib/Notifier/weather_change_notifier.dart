import 'package:flutter/cupertino.dart';
import 'package:weatherappv2/Models/weather.dart';
import 'package:weatherappv2/Services/weather_service.dart';

class WeatherChangeNotifier extends ChangeNotifier {
  final WeatherService _weatherService;

  WeatherChangeNotifier(this._weatherService);

  List<Weather> _weathers = [];

  List<Weather> get weathers => _weathers;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> getWeathers() async {
    _isLoading = true;
    notifyListeners();
    _weathers = await _weatherService.getWeathers();
    _isLoading = false;
    notifyListeners();
  }
}

class WeatherIconChangeNotifier extends ChangeNotifier {

}