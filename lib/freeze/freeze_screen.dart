import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FreezeScreen extends StatefulWidget {
  const FreezeScreen({Key? key}) : super(key: key);

  @override
  State<FreezeScreen> createState() => _FreezeScreenState();
}

class _FreezeScreenState extends State<FreezeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.helloWorld),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            context.showCustomSnackBar(message: 'Message delete', textColor: Colors.orangeAccent);
          },
          child: Text('Click Me'),
        ),
      ),
    );
  }
}

extension SnackBarExtention on BuildContext {
  void showCustomSnackBar({
    required String message,
    Color textColor = Colors.white,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
