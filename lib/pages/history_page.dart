// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../models/price.dart';
import '../utils/routes.dart';
import 'chart.dart';

class HistoryPage extends StatelessWidget {
  final index;
  final Price? price;
  const HistoryPage({this.price, this.index});

  @override
  Widget build(BuildContext context) {
    String changePercentage;
    //calculating the change % of the stock
    changePercentage =
        ((price!.data[index].change / price!.data[index].price) * 100)
            .toStringAsFixed(2);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 240, 168, 192),
        title: Text(price!.data[index].sid.toString()),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.HomePage);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          Card(
            color: Color.fromARGB(255, 215, 181, 221),
            elevation: 0,
            child: Row(
              children: [
                Text(price!.data[index].price.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18))
                    .p2(),

                /** If the change in the stock price is
                 * +ve or == 0 it will show greem color, else it 
                 * will show red
                 */

                price!.data[index].change >= 0
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
                Text("₹${price!.data[index].change}  ",
                    style: TextStyle(fontSize: 18)),
                Text("$changePercentage%", style: TextStyle(fontSize: 18)),
              ],
            ).p4(),
          ).py8(),
          Center(
              child: SizedBox(
            height: 400,
            child: Chart(),
          )),
        ],
      ),
    );
  }
}


  
