import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';


class CheckInternetConnectionWidget extends StatelessWidget {
  final AsyncSnapshot<ConnectivityResult> snapshot;
  final Widget widget ;
  const CheckInternetConnectionWidget({
    Key? key,
    required this.snapshot,
    required this.widget
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (snapshot.connectionState) {
      case ConnectionState.active:
        final state = snapshot.data!;
        switch (state) {
          case ConnectivityResult.none:
            return Center(child: const Text('Not connected'));
          default:
            return  widget;
        }
        break;
      default:
        return const Text('');
    }
  }
}


class InternetConnectivityScreen extends StatelessWidget {
  InternetConnectivityScreen({Key? key}) : super(key: key);

  List<Color> colors = [Colors.redAccent, Colors.purple , Colors.pinkAccent, Colors.black, Colors.teal, Colors.green, Colors.grey];
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    Connectivity connectivity =  Connectivity() ;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Internet Connectivity'),
      ),
      body: SafeArea(
        child: StreamBuilder<ConnectivityResult>(
          stream: connectivity.onConnectivityChanged,
          builder: (_, snapshot){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CheckInternetConnectionWidget(
                snapshot: snapshot,
                widget: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: 120,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                  color: colors[random.nextInt(7)],
                                  height: 100,
                                  child: Center(child: Text(index.toString()))),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ) ;
          },
        ),
      ),
    );
  }
}