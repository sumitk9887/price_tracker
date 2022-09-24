// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Stocks'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Go to history',
            onPressed: () {},
            icon: const Icon(Icons.history),
          ),
          IconButton(
            tooltip: 'Retrive live price',
            onPressed: () {},
            icon: const Icon(Icons.play_circle),
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 35,
            child: InkWell(
                onTap: () {},
                child: Row(children: [
                  Text(
                    'RELI',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.pink, fontSize: 20),
                  ),
                  Text("₹500"),
                  Icon(
                    Icons.arrow_drop_up,
                    color: Colors.green,
                  ),
                ])),
          ).p12(),
          InkWell(
              onTap: () {
                print("hello");
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'RELI',
                      textAlign: TextAlign.justify,
                    ),
                    Text("₹500"),
                    Icon(
                      Icons.arrow_drop_up,
                      color: Colors.green,
                    ),
                  ]))
        ],
      ),
    ));
  }
}
