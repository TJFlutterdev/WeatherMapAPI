
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:weatherappv2/Models/Weather.dart';

class WeatherService {

  static const String weatherMapApi = "0b5ec05d1b0cccb4fb6ee6a21e563eac";
  static const String weatherMapApiHttp = "http://api.openweathermap.org/data/2.5/forecast?";
  static const String parisLat = "48.856614";
  static const String parisLon = "2.3522219";

  Future<List<Weather>> getWeathers() async {
    await Future.delayed(const Duration(seconds: 5));
    List<Weather> weatherList = [];
    var url = Uri.parse(
        "${weatherMapApiHttp}lat=$parisLat&lon=$parisLon&appid=$weatherMapApi&lang=fr&units=metric");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> j = json.decode(response.body);
      List l = j['list'];

      for (int i = 0; i < l.length; i++) {
        DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(
            l[i]['dt_txt']);
        if (dateTime.hour == 12) {
          weatherList.add(Weather(
            temp: l[i]['main']['temp'] as double,
            description: l[i]['weather'][0]['description'],
            dateTime: DateFormat("yyyy-MM-dd HH:mm:ss").parse(l[i]['dt_txt']),
            weatherIconHttp: 'http://openweathermap.org/img/wn/${l[i]['weather'][0]['icon']}@2x.png',
          ));
        }
      }
      return weatherList;
    } else {
      throw Exception(response.body);
    }
  }

}