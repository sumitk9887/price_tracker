// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../utils/routes.dart';
import 'package:fl_chart/fl_chart.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TCS"),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.HomePage);
              },
              icon: Icon(Icons.arrow_back)),
        ),

        // ignore: prefer_const_literals_to_create_immutables
        body: Card(
          color: Color.fromARGB(255, 227, 135, 165),
          elevation: 0,
          child: Row(
            children: [
              Text("1127.25",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18))
                  .p2(),
              Icon(
                Icons.arrow_drop_down_outlined,
                color: Colors.green,
                size: 40,
              ),
              Text("24.58 (+0.48%)", style: TextStyle(fontSize: 18))

              


            ],
          ).p4(),
        ).py8(),
        
        );
        




  }
}
