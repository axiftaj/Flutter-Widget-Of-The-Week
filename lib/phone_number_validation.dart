
import 'package:flutter/material.dart';


class PhoneNumberValidation extends StatefulWidget {
  const PhoneNumberValidation({Key? key}) : super(key: key);

  @override
  State<PhoneNumberValidation> createState() => _PhoneNumberValidationState();
}

class _PhoneNumberValidationState extends State<PhoneNumberValidation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('asd'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text('bottom sheet mode'),
              const PhoneNumberInput(
                initialCountry: 'SA',
                locale: 'it',
                countryListMode: CountryListMode.bottomSheet,
                contactsPickerPosition: ContactsPickerPosition.suffix,
              ),
              const SizedBox(
                height: 50,
              ),
              const Text('dialog mode'),
              const PhoneNumberInput(
                initialCountry: 'SA',
                locale: 'it',
                countryListMode: CountryListMode.dialog,
                contactsPickerPosition: ContactsPickerPosition.suffix,
              ),
              const SizedBox(
                height: 50,
              ),
              const Text('custom border & custom controller'),
              PhoneNumberInput(
                initialCountry: 'TN',
                locale: 'ar',
                controller: PhoneNumberInputController(
                  context,
                ),
                countryListMode: CountryListMode.dialog,
                contactsPickerPosition: ContactsPickerPosition.suffix,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.purple)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.purple)),
                errorText: 'error',
              ),
              const SizedBox(
                height: 50,
              ),
              const Text('bottom picker widget with custom widget'),
              const PhoneNumberInput(
                initialCountry: 'YE',
                locale: 'it',
                countryListMode: CountryListMode.dialog,
                contactsPickerPosition: ContactsPickerPosition.bottom,
                pickContactIcon: Card(
                  color: Colors.blueGrey,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'select from contacts',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text('custom picker icon , no flag, hint'),
              const PhoneNumberInput(
                locale: 'it',
                countryListMode: CountryListMode.bottomSheet,
                contactsPickerPosition: ContactsPickerPosition.suffix,
                pickContactIcon: Icon(Icons.add),
                showSelectedFlag: false,
                hint: 'XXXXXXXXXXX',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
