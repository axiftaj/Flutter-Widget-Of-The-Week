import 'package:flutter/material.dart';

class AnimatedListViewBuilderWidget extends StatefulWidget {
  const AnimatedListViewBuilderWidget({super.key});

  @override
  State<AnimatedListViewBuilderWidget> createState() => _AnimatedListViewBuilderWidgetState();
}

class _AnimatedListViewBuilderWidgetState extends State<AnimatedListViewBuilderWidget> {


  /// Will used to access the Animated list
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  /// This holds the items
  List<int> _items = [];

  /// This holds the item count
  int counter = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            listKey.currentState!.removeItem(0, (_, animation) => sizeIt(context, 0, animation),
                duration: const Duration(milliseconds: 500));
            _items.removeAt(0);
          }, icon:  const Icon(Icons.remove_circle_outline))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          listKey.currentState!.insertItem(0, duration: const Duration(milliseconds: 500));
          _items = []..add(counter++)
            ..addAll(_items);
        },
      ),
      body: SafeArea(
        child: AnimatedList(
          key: listKey,
          initialItemCount: _items.length,
          itemBuilder: (context, index, animation){
            return InkWell(
                onTap: (){
                  listKey.currentState!.removeItem(0, (_, animation) => sizeIt(context, 0, animation),
                      duration: const Duration(milliseconds: 500));
                  _items.removeAt(index);
                },
                child: slideIt(context, index, animation));
          },
        ),
      ),
    );
  }


  // slide transition animation
  Widget slideIt(BuildContext context, int index, animation) {
    int item = _items[index];
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(animation),
      child: SizedBox( // Actual widget to display
        height: 128.0,
        child: Card(
          color: Colors.primaries[item % Colors.primaries.length],
          child: Center(
            child: Text('Item $item', style: Theme.of(context).textTheme.headline4),
          ),
        ),
      ),
    );
  }


  Widget sizeIt(BuildContext context, int index, animation) {
    int item = _items[index];
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child: SizedBox(
        height: 100.0,
        child: Card(
          color: Colors.primaries[item % Colors.primaries.length],
          child: Center(
            child: Text('Item $item', style: Theme.of(context).textTheme.headline4),
          ),
        ),
      ),
    );
  }
}