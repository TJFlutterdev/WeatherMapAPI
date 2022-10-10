import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherappv2/Notifier/WeatherChangeNotifier.dart';
import 'package:weatherappv2/Pages/sign_in.dart';
import 'package:weatherappv2/Pages/sign_up.dart';
import 'package:weatherappv2/Pages/weather_list.dart';
import 'package:weatherappv2/Routes/routes.dart';
import 'package:weatherappv2/Services/weather_service.dart';

class MyRouter {

  static String initialRoute() {
    if (FirebaseAuth.instance.currentUser != null) {
      return Routes.weatherList;
    } else {
      return Routes.signIn;
    }
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.signIn:
        return MaterialPageRoute(builder: (_) => const SignIn());
      case Routes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUp());
      case Routes.weatherList:
        return MaterialPageRoute(builder: (_) => ChangeNotifierProvider(
          create: (_) => WeatherChangeNotifier(WeatherService()),
          child: const WeatherList(),
        ));
      default:
        return MaterialPageRoute(builder: (_) => const SignIn());
    }
  }
}