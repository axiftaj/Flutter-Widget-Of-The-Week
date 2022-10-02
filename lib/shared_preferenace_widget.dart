import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferenceWidget extends StatefulWidget {
  const SharedPreferenceWidget({Key? key}) : super(key: key);

  @override
  State<SharedPreferenceWidget> createState() => _SharedPreferenceWidgetState();
}

class _SharedPreferenceWidgetState extends State<SharedPreferenceWidget> {
  
  String name = '' ;
  late int age ;

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();

    isLogin();
  }

  void isLogin()async{
    SharedPreferences sp = await SharedPreferences.getInstance() ;
    name = sp.getString('string') ?? '';
    age = sp.getInt('age') ?? 0;
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preferance'),
      ),
      body: Column(
        children: [
          Text(name.toString()),
          Text(age.toString()),
          FutureBuilder(
            future: SharedPreferences.getInstance(),
              builder: (context ,AsyncSnapshot<SharedPreferences> snapshot){
                return Text(snapshot.data!.getString('string').toString());
              }
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: ()async{

            SharedPreferences sp = await SharedPreferences.getInstance() ;

            sp.setInt('age', 25);
            sp.setDouble('lucky_number', 20.2);
            sp.setString('string', 'Asif Taj');
            sp.setBool('isLogin', false);

            setState(() {
              
            });

          },
        child: Icon(Icons.add),
      ),
    );
  }
}

