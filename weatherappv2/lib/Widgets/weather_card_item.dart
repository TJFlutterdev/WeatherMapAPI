import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherappv2/Models/weather.dart';
import 'package:weatherappv2/Tools/string_extension.dart';

class WeatherCardItem {
  final Weather weather;

  WeatherCardItem(this.weather);

  Widget buildCard(BuildContext context) {

    return Container(
        color: Colors.white,
        child: Row(
          children: [
            Image.network(
              weather.weatherIconHttp,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat("dd-MM-yyyy    HH:mm").format(weather.dateTime)),
                Text("${weather.temp.toString()}°C"),
                Text(weather.description.capitalize()),
              ],
            )
          ],

        ));
  }
}