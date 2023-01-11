
import 'dart:async';

import 'package:asif/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DumyScreen extends StatefulWidget {
  const DumyScreen({Key? key}) : super(key: key);

  @override
  State<DumyScreen> createState() => _DumyScreenState();
}

class _DumyScreenState extends State<DumyScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Timer.periodic(Duration(seconds: 1), (timer) {
    //   counter++;
    // });
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Gajawa ka halwa'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => CounterProvider(),
        child: Consumer<CounterProvider>(
          builder: (context, provider, value){
            return Column(
              children: [
                Center(
                  child: Text(provider.counter.toString(), style: TextStyle(fontSize: 50),),
                ),
                Container(
                  height: 200,
                  width: 200,
                  color: Colors.red.withOpacity(provider.opacity),
                ),
                Slider(value: provider.opacity, onChanged: (value){

                  provider.setOpacity(value);
                }),
                TextButton(
                    onPressed: (){
                      provider.setCounter();
                    }, child: Text('Increment'))
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){

            setState(() {

            });
          }
      ),
    );
  }
}
