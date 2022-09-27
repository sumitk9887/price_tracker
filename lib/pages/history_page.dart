// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../models/price.dart';
import '../utils/routes.dart';

class HistoryPage extends StatefulWidget {
  final StreamController? streamController;
  final index;
  final Price? price;
  const HistoryPage({this.price, this.index, this.streamController});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    String changePercentage;
    changePercentage =
        ((widget.price!.data[widget.index].change / widget.price!.data[widget.index].price) * 100)
            .toStringAsFixed(2);
    // ignore: duplicate_ignore
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.price!.data[widget.index].sid.toString()),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.HomePage);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: StreamBuilder<dynamic>(
        initialData: widget.streamController?.stream,
        
        builder: (context, snapshort) {
          return Card(
            color: Color.fromARGB(255, 227, 135, 165),
            elevation: 0,
            child: Row(
              children: [
                Text(widget.price!.data[widget.index].price.toString(),
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18))
                    .p2(),
                widget.price!.data[widget.index].change >= 0
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
                Text("₹${widget.price!.data[widget.index].change}  ",
                    style: TextStyle(fontSize: 18)),
                Text("$changePercentage%", style: TextStyle(fontSize: 18))
              ],
            ).p4(),
          ).py8();
        }
      ),
    );
  }
}


// class HistoryPage extends StatefulWidget {
//   final Price? price;
//   HistoryPage({this.price});

//   @override
//   State<HistoryPage> createState() => _HistoryPageState();
// }

// class _HistoryPageState extends State<HistoryPage> {






  
