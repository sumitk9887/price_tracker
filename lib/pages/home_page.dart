// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:price_tracker/models/price.dart';
import 'package:price_tracker/pages/history_page.dart';
import 'package:price_tracker/services/api_manager.dart';
import "package:velocity_x/velocity_x.dart";
import 'package:http/http.dart' as http;

import '../buttons/gesture_icon.dart';
import '../buttons/history_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Price>? _priceModel;

  StreamController<Price> _streamController = StreamController();

  @override
  void initState() {
    _priceModel = API_Manager().getPrice();

    Timer.periodic(Duration(seconds: 1), (timer) {
      getPrice();
    });

    super.initState();
  }

  Future<Price?> getPrice() async {
    var client = http.Client();
    var newsModel;
    try {
      var response = await client.get(Uri.parse(
          "https://api.tickertape.in/stocks/quotes?sids=TCS,RELI,HDBK,INFY,ITC,MRF,HDFC,TATA,ACC,RIL"));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = Price.fromJson(jsonMap);

        _streamController.sink.add(newsModel);
      }
    } catch (Exception) {
      Text(Exception.toString());
    }

    return newsModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.pinkAccent[100],
          title: Text('Stocks'),
          actions: <Widget>[
            FutureBuilder(
                future: _priceModel,
                builder: (context, snapshot) {
                  return HistoryButton(
                    snapshot: snapshot.data,
                  ); //history button
                }),
            Center(child: PlayPauseButton()), //gesture play pause button
          ],
        ),
        body: StreamBuilder<Price>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data?.data.length,
              itemBuilder: (context, index) {
                var dataPrice = snapshot.data?.data[index];
                return Card(
                  color: Colors.purple[200],
                  child: ListTile(
                    leading: dataPrice == null
                        ? CircularProgressIndicator()
                        : Text(dataPrice.sid.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18)),
                    title: dataPrice != null
                        ? Text("₹${dataPrice.price}", textAlign: TextAlign.end)
                        : Text(""),
                    trailing: dataPrice != null
                        ? dataPrice.change > 0
                            ? Icon(
                                Icons.arrow_drop_up_outlined,
                                color: Colors.green,
                                size: 40,
                              )
                            : Icon(
                                Icons.arrow_drop_down_outlined,
                                color: Colors.red,
                                size: 40,
                              )
                        : Text("00.00"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistoryPage(
                                    price: snapshot.data,
                                    index: index,
                                  )));
                    },
                  ),
                ).p2();
              },
            );
          },
        ));
  }
}
