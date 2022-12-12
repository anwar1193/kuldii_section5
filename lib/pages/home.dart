import 'dart:convert';

import 'package:flutter/material.dart';
import '../widgets/summary_item.dart';
import 'package:http/http.dart' as myhttp;
import '../model/summary_covid19.dart';

class HomePage extends StatelessWidget {
  late Summary dataSummary; // Summary diambil dari nama class di model nya

  Future getSummary() async {
    var response = await myhttp.get(
      Uri.parse("https://covid19.mathdro.id/api"),
    );

    Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;

    dataSummary = Summary.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Covid 19 Real Time"),
      ),
      body: FutureBuilder(
          future: getSummary(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("LOADING DATA ....."),
              );
            }
            return Column(
              children: [
                SummaryItem("CONFIRMED", "${dataSummary.confirmed.value}"),
                SummaryItem("DEATH", "${dataSummary.deaths.value}"),
              ],
            );
          }),
    );
  }
}
