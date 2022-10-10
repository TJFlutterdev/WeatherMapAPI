import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weatherappv2/API/WeatherMapAPI.dart';
import 'package:weatherappv2/Models/Weather.dart';
import 'package:weatherappv2/Routes/routes.dart';
import 'package:weatherappv2/Widgets/weather_card_item.dart';

class WeatherList extends StatefulWidget {

  const WeatherList({Key? key}) : super(key: key);

  @override
  _WeatherState createState() => _WeatherState();

}

class _WeatherState extends State<WeatherList> {
    late String username;
  @override
  void initState() {
    username = FirebaseAuth.instance.currentUser!.displayName!;
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
    return FutureBuilder<List<Weather>>(
      builder: (context, AsyncSnapshot<List<Weather>> snapshot){
        if (snapshot.hasData) {
          List<WeatherCardItem> listCard = getListItem(snapshot.requireData);

          return ListView.builder(
              itemCount: listCard.length,
              itemBuilder: (context, index) {
                final item = listCard[index];
                return item.buildCard(context);
              }
          );
        } else {
          return const SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: CircularProgressIndicator(),
              )
          );
        }
      },
      future: WeatherMapAPI.getForecast(),
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