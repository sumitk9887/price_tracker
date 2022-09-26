// ignore_for_file: prefer_const_constructors
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:price_tracker/utils/routes.dart';
import "package:velocity_x/velocity_x.dart";
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String? stringResponse;
Map? mapResponse;
List? listResponse;

class _HomePageState extends State<HomePage> {
  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse(
        "https://api.tickertape.in/stocks/quotes?sids=TCS,RELI,HDBK,INFY,ITC,MRF,HDFC,TATA,ACC"));
    if (response.statusCode == 200) {
      setState(() {
        //stringResponse = response.body;
        mapResponse = json.decode(response.body);
        listResponse = mapResponse!["data"];
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
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
            IconButton(
              tooltip: 'Retrive live price',
              onPressed: () {},
              icon: const Icon(Icons.play_circle),
            )
          ],
        ),
        body: ListView.builder(
          itemCount: listResponse == null ? 0 : listResponse?.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.purple[200],
              child: ListTile(
                leading: Expanded(
                  child: listResponse == null
                      ? CircularProgressIndicator()
                      : Text(listResponse![index]["sid"].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18)),
                ),
                title: Text(listResponse![index]["price"].toString(),
                    textAlign: TextAlign.end),
                trailing: listResponse![index]["change"] > 0
                    ? Icon(
                        Icons.arrow_drop_up_outlined,
                        color: Colors.green,
                        size: 40,
                      )
                    : Icon(
                        Icons.arrow_drop_down_outlined,
                        color: Colors.red,
                        size: 40,
                      ),
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.HistoryPage);
                },
              ),
            ).p2();
          },
        ));
  }
}
