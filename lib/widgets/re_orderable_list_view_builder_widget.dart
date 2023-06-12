import 'package:flutter/material.dart';


class ReorderableListViewWidget extends StatefulWidget {
  const ReorderableListViewWidget({Key? key}) : super(key: key);

  @override
  State<ReorderableListViewWidget> createState() => _ReorderableListViewWidgetState();
}

class _ReorderableListViewWidgetState extends State<ReorderableListViewWidget> {

  final List<String> _products = ['Apple' , 'Mango' ,"Orange" , "Banana" , "Strabery" ,'Cherry'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscribe'),
      ),
      body: ReorderableListView.builder(
          itemCount: _products.length,
          itemBuilder: (context, index) {
            return Card(
              key: ValueKey(_products[index]),
              color: Colors.teal.shade100,
              elevation: 1,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                contentPadding: const EdgeInsets.all(25),
                title: Text(
                  _products[index],
                  style: const TextStyle(fontSize: 18),
                ),
                trailing: const Icon(Icons.drag_handle),
                onTap: () {},
              ),


            );
          },
          // The reorder function
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (newIndex > oldIndex) {
                newIndex = newIndex - 1;
              }
              final element = _products.removeAt(oldIndex);
              print(_products.length);
              print(element);
              _products.insert(newIndex, element);
              print(_products.length);

            });
          }),
    );
  }

}
