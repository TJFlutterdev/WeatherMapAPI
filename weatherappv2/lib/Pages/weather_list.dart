import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherappv2/Models/Weather.dart';
import 'package:weatherappv2/Notifier/WeatherChangeNotifier.dart';
import 'package:weatherappv2/Routes/routes.dart';
import 'package:weatherappv2/Widgets/weather_card_item.dart';

class WeatherList extends StatefulWidget {

  const WeatherList({Key? key}) : super(key: key);

  @override
  _WeatherState createState() => _WeatherState();

}

class _WeatherState extends State<WeatherList> {
    late String username;

    late List<WeatherCardItem> listItems;

  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      username = FirebaseAuth.instance.currentUser!.displayName!;
    } else {
      username = 'plop';
    }
    Future.microtask(() => context.read<WeatherChangeNotifier>().getWeathers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(username),
            actions: [
              PopupMenuButton(
                  itemBuilder: (context){
                    return [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text("Déconnexion"),
                      ),
                    ];
                  },
                  onSelected:(value){
                    if(value == 0){
                      disconnect();
                      Navigator.of(context).pushReplacementNamed(Routes.signIn);
                    }
                  }
              ),
            ]
        ),
        body: buildList()
    );
  }


  Widget buildList() {
    return Consumer<WeatherChangeNotifier>(
      builder: (context, notifier, child) {
        if (notifier.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
            itemCount: notifier.weathers.length,
            itemBuilder: (_, index) {
              final weather = notifier.weathers[index];
              return WeatherCardItem(weather).buildCard(context);
            },
        );
      }

    );
  }

  List<WeatherCardItem> getListItem(List<Weather> data) {
    List<WeatherCardItem> list = [];

    for (int i = 0; i < data.length; i++) {
      list.add(WeatherCardItem(data[i]));
    }
    return list;
  }

  void disconnect() async {
    FirebaseAuth.instance.signOut();
  }

}