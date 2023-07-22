
import 'package:asif/provider/app_language/app_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart' ;
import 'package:provider/provider.dart';


enum SampleItem { itemOne, itemTwo }
class ChangeLanguageWidget extends StatefulWidget {
  const ChangeLanguageWidget({Key? key}) : super(key: key);

  @override
  State<ChangeLanguageWidget> createState() => _ChangeLanguageWidgetState();
}

class _ChangeLanguageWidgetState extends State<ChangeLanguageWidget> {

  SampleItem? selectedMenu;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.helloWorld.toString()),
        actions: [
          Consumer<AppLanguage>(
              builder: (context, provider, child){
                return PopupMenuButton<SampleItem>(
                  initialValue: selectedMenu,
                  // Callback that sets the selected popup menu item.
                  onSelected: (SampleItem item) {

                    if(SampleItem.itemOne.name == item.name){
                      provider.changeLanguage(const Locale('es'));
                    }else {
                      provider.changeLanguage(const Locale('en'));
                    }
                    // provider.changeLanguage(const Locale('en'));

                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                    const PopupMenuItem<SampleItem>(
                      value: SampleItem.itemOne,
                      child: Text('Spanish'),
                    ),
                    const PopupMenuItem<SampleItem>(
                      value: SampleItem.itemTwo,
                      child: Text('English'),
                    ),

                  ],
                );
              }
          ),


        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 100,),
            Text(AppLocalizations.of(context)!.login.toString()),
            SizedBox(height: 30,),
            TextFormField(
              decoration:  InputDecoration(
                  hintText: AppLocalizations.of(context)!.email.toString() ,
                enabledBorder: OutlineInputBorder()
              ),
            ),
            const  SizedBox(height: 20,),
            TextFormField(
              decoration:  InputDecoration(
                  hintText: AppLocalizations.of(context)!.password.toString() ,
                  enabledBorder: OutlineInputBorder()
              ),
            ),
            const  SizedBox(height: 50,),
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green
              ),

              child: Center(child: Text(AppLocalizations.of(context)!.login.toString())),
            )
          ],
        ),
      ),
    );
  }
}
