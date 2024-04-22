import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FreezeScreen extends StatefulWidget {
  const FreezeScreen({Key? key}) : super(key: key);

  @override
  State<FreezeScreen> createState() => _FreezeScreenState();
}

class _FreezeScreenState extends State<FreezeScreen> {
  List<PersonModel> personList = [PersonModel(name: null), PersonModel(name: 'John'), PersonModel(name: 'John')];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.helloWorld),
      ),
      body: ListView.builder(
          itemCount: personList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(personList[index].name ?? ''),
            );
          }),
      floatingActionButton: FloatingActionButton(onPressed: () {
        var john = PersonModel(name: 'John');
        var john2 = PersonModel(
          name: 'John',
        );

        print(john2 == john);
        Map<String, dynamic> data = {
          'name': 'Asif Taj',
        };

        PersonModel personModel = PersonModel.fromJson(data);
        print(personModel.name.toString());
        personModel = personModel.copyWith(name: 'new value');
        if (kDebugMode) {
          print(personModel.name);
        }
      }),
    );
  }
}

class PersonModel {
  String? name;

  PersonModel({this.name});

  @override
  bool operator ==(Object other) => identical(this, other) || other is PersonModel && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;

  PersonModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }

  PersonModel copyWith({
    String? name,
  }) {
    return PersonModel(name: name ?? name);
  }

  @override
  String toString() {
    return 'Person(firstName: $name)';
  }
}
