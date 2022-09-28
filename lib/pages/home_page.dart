// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:price_tracker/models/price.dart';
import 'package:price_tracker/services/api_manager.dart';

import '../buttons/gesture_icon.dart';
import '../buttons/history_button.dart';
import 'body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Price>? _priceModel;

  @override
  void initState() {
    _priceModel = API_Manager().getPrice();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 240, 168, 192),
          title: Text('Stocks',style: TextStyle(fontSize: 25,color: Colors.black ),),
          actions: <Widget>[
            FutureBuilder(
                future: _priceModel,
                builder: (context, snapshot) {

                  /**calling history button
                   * @param snapshot 
                   * @returns Icon button which on click
                   * navigates to history page */  

                  return HistoryButton(
                    snapshot: snapshot.data,
                  ); //history button
                }),
            Center(child: PlayPauseButton()), //gesture play pause button
          ],
        ),
        body: SafeArea(child: Body()));
  }
}
