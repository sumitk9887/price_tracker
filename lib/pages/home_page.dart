// ignore_for_file: prefer_const_constructors
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:price_tracker/models/price.dart';
import 'package:price_tracker/pages/history_page.dart';
import 'package:price_tracker/services/api_manager.dart';
import 'package:price_tracker/utils/routes.dart';
import "package:velocity_x/velocity_x.dart";
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// String? stringResponse;
// Map? mapResponse;
// List? listResponse;

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // Future apicall() async {
  //   http.Response response;
  //   response = await http.get(Uri.parse(
  //       "https://api.tickertape.in/stocks/quotes?sids=TCS,RELI,HDBK,INFY,ITC,MRF,HDFC,TATA,ACC"));
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       //stringResponse = response.body;
  //       mapResponse = json.decode(response.body);
  //       listResponse = mapResponse!["data"];
  //     });
  //   }
  // }

  //
  late AnimationController _animationController;

  Future<Price>? _priceModel;

  @override
  void initState() {
    _priceModel = API_Manager().getPrice();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    super.initState();
  }

  bool currentlyPlaying = false;
  void _iconTapped() {
    if (currentlyPlaying == false) {
      currentlyPlaying = true;
      _animationController.forward();
    } else {
      currentlyPlaying = false;
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent[100],
          title: Text('Stocks'),
          actions: <Widget>[
            IconButton(
              tooltip: 'Go to history',
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.HistoryPage);
              },
              icon: const Icon(Icons.history),
            ),
            Center(
              child: GestureDetector(
                onTap: _iconTapped,
                child: AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  progress: _animationController,
                  size: 40,
                ),
              ),
            ),
            // IconButton(
            //   tooltip: 'Retrive live price',
            //   onPressed: () {},
            //   icon: const Icon(Icons.play_circle),
            // )
          ],
        ),
        body: FutureBuilder<Price>(
          future: _priceModel,
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
                        ? Text("₹" + dataPrice.price.toString(),
                            textAlign: TextAlign.end)
                        : Text("null"),
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
