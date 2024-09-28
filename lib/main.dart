import 'package:asif/provider/app_language/app_language.dart';
import 'package:asif/screen/pagination_screen/pagination_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart' ;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


AppLanguage appLanguage = AppLanguage();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final String languageCode = prefs.getString('language_code') ?? '' ;
  runApp(  MyApp(locale: languageCode ));
}

class MyApp extends StatelessWidget {
  final String locale ;
  const MyApp({Key? key , required this.locale}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppLanguage()),
      ],
      child: Consumer<AppLanguage>(
        builder: (context, provider, child) {

          if (provider.appLocal == null) {
            if (locale.isEmpty) {
              provider.changeLanguage(Locale('en'));
            } else {
              provider.changeLanguage(Locale(locale));
            }
          }
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.dark
            ),
            locale: locale == '' ? Locale( 'en') : provider.appLocal  ==  null ?  Locale(locale) :  Provider.of<AppLanguage>(context).appLocal,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English
              Locale('es'), // Spanish
            ],

            home: const PaginationScreen(),
          );
        },
      )

    );
  }


}
