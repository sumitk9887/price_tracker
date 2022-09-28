import 'package:flutter/material.dart';

import '../models/price.dart';
import '../pages/history_page.dart';

class HistoryButton extends StatelessWidget {
  final Price? snapshot;
  const HistoryButton({super.key, this.snapshot});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.black,
      tooltip: 'Go to history',
      onPressed: () {
        var tempPrice = 0;
        var count = 0;
        for (var i = 0; i < snapshot!.data.length.toInt(); i++) {
          if (snapshot!.data[i].price > tempPrice) {
            tempPrice = tempPrice + snapshot!.data[i].price.toInt();
            count = count + i;
          }
        }

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HistoryPage(
                      price: snapshot,
                      index: count,
                    )));
      },
      icon: const Icon(Icons.history),
    );
  }
}
