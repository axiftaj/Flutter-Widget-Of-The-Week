import 'package:flutter/material.dart';

class CountryCodeToFlagExtension extends StatelessWidget {
  const CountryCodeToFlagExtension({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Extension'),
      ),
      body: Center(
          child: Text("IND".toFlag.toString(), style:  const TextStyle(fontSize: 50),)),
    );
  }
}


extension ConvertFlag on String {
  String get toFlag {
    return  (this).toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
            (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
  }
}