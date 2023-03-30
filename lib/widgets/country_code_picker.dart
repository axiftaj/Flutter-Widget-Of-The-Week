import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';


class CountryCodePickerWidget extends StatefulWidget {
  const CountryCodePickerWidget({Key? key}) : super(key: key);

  @override
  State<CountryCodePickerWidget> createState() => _CountryCodePickerWidgetState();
}

class _CountryCodePickerWidgetState extends State<CountryCodePickerWidget> {
  String countryCode = '' ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country code picker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          Text(countryCode.toString()),
          Center(
            child: TextButton(onPressed: (){
              showCountryPicker(
                  context: context,
                  showPhoneCode: true,
                  countryListTheme: CountryListThemeData(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10)
                    ),
                    inputDecoration: InputDecoration(
                      hintText: 'Start typing to sear' ,
                      labelText: 'Search ' ,
                    )
                  ),
                  favorite: ['PK'],
                  onSelect: (Country value){
                    print(value.countryCode.toString());
                    print(value.phoneCode.toString());

                    countryCode = value.phoneCode.toString();
                    setState(() {

                    });
                  }
              );
            }, child: Text('Tap')),
          )
        ],
      ),
    );
  }
}
