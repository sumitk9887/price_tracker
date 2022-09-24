// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Card(
            color: Colors.amber,
            child: ListTile(
              leading: Text('RELI',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
              title: Text("500", textAlign: TextAlign.end),
              trailing: Icon(
                Icons.arrow_drop_up_outlined,
                color: Colors.green,
              ),
              onTap: () {},
            ),
          ).p2(),
          Card(
            color: Colors.amber,
            child: ListTile(
              leading: Text('RELI',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
              title: Text("500", textAlign: TextAlign.end),
              trailing: Icon(
                Icons.arrow_drop_up_outlined,
                color: Colors.green,
              ),
              onTap: () {},
            ),
          ).p2(),
        ],
      ),
    );
  }
}
