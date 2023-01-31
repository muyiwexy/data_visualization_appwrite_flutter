import 'package:data_visualization/authprovider/authstate.dart';
import 'package:data_visualization/component/linechartwidget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:collection/collection.dart';

class Homepage extends StatefulWidget {
  final String title;
  const Homepage({super.key, required this.title});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<NumOrder> get numOrders {
    AuthProvider state = Provider.of<AuthProvider>(context, listen: false);
    final randomNumbers = state.itemone!;
    final mapper = randomNumbers.asMap().entries.map(
      (e) {
        int idx = e.key;
        final item = randomNumbers[idx].ordernumber;
        return item;
      },
    ).toList();

    return mapper
        .mapIndexed(
            (index, element) => NumOrder(x: index.toDouble(), y: element!))
        .toList();
  }

  List<Transactions> get transactions {
    AuthProvider state = Provider.of<AuthProvider>(context, listen: false);
    final randomNumbers = state.itemone!;
    final mapper = randomNumbers.asMap().entries.map(
      (e) {
        int idx = e.key;
        final item = randomNumbers[idx].transactionnumber;
        return item;
      },
    ).toList();

    return mapper
        .mapIndexed(
            (index, element) => Transactions(x: index.toDouble(), y: element!))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, state, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Color.fromARGB(221, 15, 11, 43),
          elevation: 0,
        ),
        body: SafeArea(
            child: state.isLoading == false
                ? circularloader()
                : buildcomponent(context, state, child)),
      );
    });
  }

  Widget circularloader() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildcomponent(context, state, child) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 0, 0, 18),
          border: Border(
              top: BorderSide(
                  width: 0.5, color: Color.fromARGB(255, 143, 143, 143)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IntrinsicWidth(
            child: Container(
                margin: const EdgeInsets.all(50.0),
                padding: const EdgeInsets.only(
                    bottom: 40.0, left: 20.0, right: 20.0),
                height: 400,
                // width:300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(255, 143, 143, 143),
                        spreadRadius: 0.5)
                  ],
                  color: const Color.fromARGB(221, 21, 21, 21),
                ),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30, top: 10),
                          child: RichText(
                              text: const TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Order Number',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25)),
                                  TextSpan(
                                      text: ' & ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25)),
                                  TextSpan(
                                      text: 'Transaction Number',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                            255,
                                            0,
                                            35,
                                            65,
                                          ),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25)),
                                ],
                              ),
                            )
                        )),
                    Expanded(
                      child: Align(
                          alignment: Alignment.center,
                          child: LineChartWidget(numOrders, transactions)),
                    )
                  ],
                )
                ),
          ),
          IntrinsicWidth(
              child: Container(
                  height: 150,
                  // margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 20.0, left: 20.0, right: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 143, 143, 143),
                          spreadRadius: 0.5)
                    ],
                    color: const Color.fromARGB(221, 21, 21, 21),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10.0, left: 5.0, right: 5.0),
                        child: const Text("Number of Order",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22)),
                      ),
                      Expanded(
                          child: Align(
                        alignment: Alignment.center,
                        child: Text("${state.itemtwo![0].productnumber}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25)),
                      ))
                    ],
                  )))
        ],
      ),
    );
  }
}

class NumOrder {
  final double x;
  final double y;

  NumOrder({required this.x, required this.y});
}

class Transactions {
  final double x;
  final double y;

  Transactions({required this.x, required this.y});
}
