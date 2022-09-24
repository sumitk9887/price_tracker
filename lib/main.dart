// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:price_tracker/pages/history_page.dart';
import 'package:price_tracker/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: HomePage(),
    routes: {
      "/":(context) => HomePage(),
      "/history_page":(context)=>HistoryPage() 
    },);
    
  }
}
