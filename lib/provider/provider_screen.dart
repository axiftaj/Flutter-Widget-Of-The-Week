
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProviderScreen extends StatefulWidget {
  const ProviderScreen({Key? key}) : super(key: key);

  @override
  State<ProviderScreen> createState() => _ProviderScreenState();
}

class _ProviderScreenState extends State<ProviderScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ChangeNotifierProvider(
        create: (_) =>  ProviderVM(),
        child: SafeArea(
          child: Consumer<ProviderVM>(
            builder: (context, value, child){
              return TextButton(onPressed: (){
                context.read<ProviderVM>().setValue();
              //  Navigator.push(context, MaterialPageRoute(builder: (context) => NewScreen()));
              }, child: Center(child: Text(context.watch<ProviderVM>().value.toString())));
            },
          ),
        ),
      ),
    );
  }
}


class NewScreen extends StatelessWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Consumer<ProviderVM>(
        builder: (context, value, child){
          return TextButton(onPressed: (){
            value.setValue();
          }, child: Center(child: Text(value.value.toString())));
        },
      ),
    );
  }
}



class ProviderVM with ChangeNotifier {

  int _value = 20 ;
  int  get value => _value ;

  setValue(){
    _value++ ;
    notifyListeners();
  }
}