// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/price.dart';
import 'history_page.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final StreamController<Price> _streamController = StreamController();

  Future<Price?> getPrice() async {
    var client = http.Client();
    var newsModel;
    try {
      var response = await client.get(Uri.parse(
          "https://api.tickertape.in/stocks/quotes?sids=TCS,RELI,HDBK,INFY,ITC,MRF,HDFC,TATA,ACC,SBIN,RIL,RAIL,BAJAJ,JBM,SBIL,SBIC,IDBI"));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = Price.fromJson(jsonMap);

        _streamController.sink.add(newsModel);
      }
    } on Exception {
      return newsModel;
    }

    return newsModel;
  }

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      getPrice();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Price>(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data?.data.length,
          itemBuilder: (context, index) {
            var dataPrice = snapshot.data?.data[index];
            return Card(
              color: const Color.fromARGB(255, 215, 181, 221),
              child: ListTile(
                leading: dataPrice == null
                    ? const CircularProgressIndicator()
                    : Text(dataPrice.sid.toString(),
                        style: const TextStyle(color: Colors.black,
                            fontWeight: FontWeight.w500, fontSize: 18)),
                title: dataPrice != null
                    ? Text("₹${dataPrice.price}", textAlign: TextAlign.end,style: const TextStyle(color: 
                    Colors.black),)
                    : const Text(""),
                trailing: dataPrice != null
                    ? dataPrice.change > 0
                        ? const Icon(
                            Icons.arrow_drop_up_outlined,
                            color: Colors.green,
                            size: 40,
                          )
                        : const Icon(
                            Icons.arrow_drop_down_outlined,
                            color: Colors.red,
                            size: 40,
                          )
                    : const Text("00.00"),
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
            );
          },
        );
      },
    );
  }
}
