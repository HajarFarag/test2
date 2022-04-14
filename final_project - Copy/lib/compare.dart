import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class SubscriberSeries {
   String year = '';
   int subscribers = 0;
   int users = 0;
   int weapon = 0;

  SubscriberSeries(
      {
        required this.year,
        required this.subscribers,
        required this.users,
        required this.weapon,
      }
      );
}

class HomePage extends StatelessWidget {
  final List<SubscriberSeries> data = [
    SubscriberSeries(
      year: "Uchigatana",
      subscribers: 281,
      users: 98,
      weapon: 1,
    ),
    SubscriberSeries(
      year: "R Rapier",
      subscribers: 227,
      users: 20,
      weapon: 2,
    ),
    SubscriberSeries(
      year: "Sacred",
      subscribers: 289,
      users: 78,
      weapon: 3,
    ),
    SubscriberSeries(
      year: "N&F",
      subscribers: 487,
      users: 2,
      weapon: 4,
    ),
    SubscriberSeries(
      year: "Stormhawk",
      subscribers: 318,
      users: 25,
      weapon: 5,
    ),
    SubscriberSeries(
      year: "Blasph",
      subscribers: 296,
      users: 36,
      weapon: 6,
    ),
    SubscriberSeries(
      year: "WingOfAstel",
      subscribers: 350,
      users: 38,
      weapon: 7,
    ),
    SubscriberSeries(
      year: "ROB",
      subscribers: 372,
      users: 95,
      weapon: 8,
    ),
    SubscriberSeries(
      year: "Poleblade",
      subscribers: 352,
      users: 63,
      weapon: 9,
    ),
    SubscriberSeries(
      year: "Gransax",
      subscribers: 394,
      users: 56,
      weapon: 10,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("Weapon Comparison Selection"),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              SubscriberChart(
                data: data,
              ),
              lineChart(
                data: data,
              ),
            ],
          ),
      ),
      backgroundColor: Colors.black54,
    );
  }
}

class SubscriberChart extends StatelessWidget {
  final List<SubscriberSeries> data;

  SubscriberChart({required this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<SubscriberSeries, String>> series = [
      charts.Series(
          id: "Subscribers",
          data: data,
          domainFn: (SubscriberSeries series, _) => series.year,
          measureFn: (SubscriberSeries series, _) => series.subscribers,
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
      )
    ];
    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                "Weapon Comparison",
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class lineChart extends StatelessWidget {
  final List<SubscriberSeries> data;

  lineChart({required this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<SubscriberSeries, int>> series = [
      charts.Series(
        id: "Subscribers",
        data: data,
        domainFn: (SubscriberSeries series, _) => series.weapon,
        measureFn: (SubscriberSeries series, _) => series.users,
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
      )
    ];
    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                "Weapon Popularity",
              ),
              Expanded(
                child: charts.LineChart(series, animate: true),             )
            ],
          ),
        ),
      ),
    );
  }
}