

import 'package:asif/provider/kam_par_ho.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DumyScreen extends StatefulWidget {
  const DumyScreen({Key? key}) : super(key: key);

  @override
  State<DumyScreen> createState() => _DumyScreenState();
}

class _DumyScreenState extends State<DumyScreen> {


  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Ghareebo'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => KamParHo(),
        builder: (context, child){
         return Consumer<KamParHo>(
             builder: (context, provider, child){
               return   Column(
                 children: [
                   Container(
                     height: 300,
                     width: 200,
                     color: Colors.red.withOpacity(provider.opacity),
                   ),
                   Slider(
                       value: provider.opacity,
                       onChanged: (value){
                         provider.setOpacity(value);

                       }
                   )
                 ],
               );
             }
         );
        },
      ),
    );
  }
}
