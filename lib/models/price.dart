import 'dart:convert';

Price priceFromJson(String str) => Price.fromJson(json.decode(str));

String priceToJson(Price data) => json.encode(data.toJson());

class Price {
  Price({
    required this.success,
    required this.data,
  });

  bool success;
  List<Datum> data;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.sid,
    required this.price,
    required this.close,
    required this.change,
    required this.high,
    required this.low,
    required this.volume,
    required this.date,
  });

  String sid;
  double price;
  double close;
  double change;
  double high;
  double low;
  int volume;
  DateTime date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        sid: json["sid"],
        price: json["price"].toDouble(),
        close: json["close"].toDouble(),
        change: json["change"].toDouble(),
        high: json["high"].toDouble(),
        low: json["low"].toDouble(),
        volume: json["volume"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "sid": sid,
        "price": price,
        "close": close,
        "change": change,
        "high": high,
        "low": low,
        "volume": volume,
        "date": date.toIso8601String(),
      };
}
