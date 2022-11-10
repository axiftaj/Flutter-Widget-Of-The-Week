import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class FlutteSlidableWidget extends StatefulWidget {
  const FlutteSlidableWidget({Key? key}) : super(key: key);

  @override
  State<FlutteSlidableWidget> createState() => _FlutteSlidableWidgetState();
}

class _FlutteSlidableWidgetState extends State<FlutteSlidableWidget> {

  final items = List<String>.generate(20, (i) => 'Item ${i + 1}');
  int second = 10 ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('asdf'),
      ),
      body: Column(
        children: [
          TextButton(onPressed: (){
            setState(() {
              second = 0 ;
            });
          }, child: Text('click')),
          Slidable(
            // Specify a key if the Slidable is dismissible.
            key:  ValueKey(1),

            startActionPane:  ActionPane(
              motion: ScrollMotion(),

              children: [
                SlidableAction(
                  onPressed: doNothing,
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: doNothing,
                  backgroundColor: Color(0xFF21B7CA),
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Share',
                ),
              ],
            ),

            // The end action pane is the one at the right or the bottom side.
            endActionPane: ActionPane(
              extentRatio: 1,
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(
                  onDismissed: () {

                    },
                confirmDismiss: ()async{
                    await Future.delayed(Duration(seconds: 2));
                    return false ;
                },
              ),
              
              dragDismissible: true,
              children:  [

                Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.red
                  ),
                  child: SlidableAction(
                    // An action can be bigger than the others.
                    onPressed: doNothing,
                    backgroundColor: Color(0xFF7BC043),
                    foregroundColor: Colors.white,
                    icon: Icons.archive,
                    label: 'Archive',
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.red
                  ),
                  child: SlidableAction(
                    onPressed: doNothing,
                    backgroundColor: Color(0xFF0392CF),
                    foregroundColor: Colors.white,
                    icon: Icons.save,
                    label: 'Save',
                  ),
                ),
              ],
            ),

            // The child of the Slidable is what the user sees when the
            // component is not dragged.
            child: const ListTile(title: Text('Slide me')),
          ),
        ],
      ),
    );
  }

  void doNothing(BuildContext context) {}
}
