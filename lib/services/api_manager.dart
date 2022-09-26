// ignore_for_file: prefer_typing_uninitialized_variables, avoid_types_as_parameter_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:price_tracker/models/price.dart';


// ignore: camel_case_types
class API_Manager {
  Future<Price> getPrice() async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client.get(Uri.parse("https://api.tickertape.in/stocks/quotes?sids=TCS,RELI,HDBK,INFY,ITC,MRF,HDFC,TATA,ACC,RIL"));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = Price.fromJson(jsonMap);
      }
    // ignore: non_constant_identifier_names
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }
}