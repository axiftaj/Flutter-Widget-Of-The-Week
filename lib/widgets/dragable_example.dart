
import 'package:flutter/material.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';


const List<Item> _items = [
  Item(
    uid: '1',
    imageProvider: 'https://flutter.dev/docs/cookbook/img-files/effects/split-check/Food1.jpg',
  ),
  Item(
    uid: '2',
    imageProvider: 'https://flutter.dev/docs/cookbook/img-files/effects/split-check/Food2.jpg',
  ),
  Item(
    uid: '3',
    imageProvider: 'https://flutter.dev/docs/cookbook/img-files/effects/split-check/Food3.jpg',
  ),
  Item(
    uid: '4',
    imageProvider: 'https://flutter.dev/docs/cookbook/img-files/effects/split-check/Food1.jpg',
  ),
  Item(
    uid: '5',
    imageProvider: 'https://flutter.dev/docs/cookbook/img-files/effects/split-check/Food2.jpg',
  ),
  Item(
    uid: '6',
    imageProvider: 'https://flutter.dev/docs/cookbook/img-files/effects/split-check/Food3.jpg',
  ),
  Item(
    uid: '7',
    imageProvider: 'https://flutter.dev/docs/cookbook/img-files/effects/split-check/Food1.jpg',
  ),
  Item(
    uid: '8',
    imageProvider: 'https://flutter.dev/docs/cookbook/img-files/effects/split-check/Food2.jpg',
  ),
  Item(
    uid: '9',
    imageProvider: 'https://flutter.dev/docs/cookbook/img-files/effects/split-check/Food3.jpg',
  ),

];


class DraggbaleExample extends StatefulWidget  {
  const DraggbaleExample({Key? key}) : super(key: key);

  @override
  State<DraggbaleExample> createState() => _DraggbaleExampleState();
}

class _DraggbaleExampleState extends State<DraggbaleExample> with TickerProviderStateMixin {


  final data = [1, 2, 3, 4, 5];
  final GlobalKey _draggableKey = GlobalKey();

  String image = 'https://flutter.dev/docs/cookbook/img-files/effects/split-check/Food3.jpg' ;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Grid'),
      ),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            DragTarget(
              builder: (context, candidateItems, rejectedItems) {
                return Transform.scale(
                  scale: candidateItems.isNotEmpty ? 1.075 : 1.0,
                  child: Material(
                    elevation: candidateItems.isNotEmpty ? 8.0 : 4.0,
                    borderRadius: BorderRadius.circular(22.0),
                    color: candidateItems.isEmpty ? const Color(0xFFF64209) : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 12.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: Image(
                              image: NetworkImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ),
                );
              },
              onWillAccept: (data) {
                print('onWillAccept: $data');
                setState(() {

                });
                return true;
              },

            ),
            Expanded(
              child: GridView.builder(

                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                  ),
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Draggable(
                        data: _items,
                        onDragEnd: (details) {
                        },
                        onDragStarted: (){
                          image = _items[index].imageProvider ;
                        },
                        dragAnchorStrategy: pointerDragAnchorStrategy,
                        feedback: DraggingListItem(
                          dragKey: _draggableKey,
                          photoProvider: _items[index].imageProvider,
                        ),
                        child: MenuListItem(
                          photoProvider: _items[index].imageProvider,
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }


}


class DraggingListItem extends StatelessWidget {
  const DraggingListItem({
    super.key,
    required this.dragKey,
    required this.photoProvider,
  });

  final GlobalKey dragKey;
  final String photoProvider;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: ClipRRect(
        key: dragKey,
        borderRadius: BorderRadius.circular(12.0),
        child: SizedBox(
          height: 120,
          width: 120,
          child: Opacity(
            opacity: 0.85,
            child: Image(
              image:NetworkImage( photoProvider),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class Item {
  const Item({
    required this.uid,
    required this.imageProvider,
  });
  final String uid;
  final String imageProvider;

}

class MenuListItem extends StatelessWidget {
  const MenuListItem({
    super.key,
    required this.photoProvider,
    this.isDepressed = false,
  });

  final String photoProvider;
  final bool isDepressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12.0,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: SizedBox(

            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
                height: isDepressed ? 100 : 90,
                width: isDepressed ? 100 : 90,
                child: Image(
                  image: NetworkImage(photoProvider),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}