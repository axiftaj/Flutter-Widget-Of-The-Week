import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';


import 'package:flutter/material.dart';




// Create a class to hold your hierarchical data (optional, could be a Map or
// any other data structure that's capable of representing hierarchical data).
class CommentsModel {
  const CommentsModel({
    required this.title,
    this.children = const <CommentsModel>[],
  });

  final String title;
  final List<CommentsModel> children;
}

class ReplyModelList {
  const ReplyModelList({
    required this.title,
    this.children = const <ReplyModelList>[],
  });

  final String title;
  final List<ReplyModelList> children;
}


class FlutterFancyTreeWidget extends StatefulWidget {
  const FlutterFancyTreeWidget({super.key});

  @override
  State<FlutterFancyTreeWidget> createState() => _FlutterFancyTreeWidgetState();
}

class _FlutterFancyTreeWidgetState extends State<FlutterFancyTreeWidget> {
  // In this example a static nested tree is used, but your hierarchical data
  // can be composed and stored in many different ways.
  static const List<CommentsModel> commentsList = <CommentsModel>[
    CommentsModel(
      title: 'Root 1',
      children: <CommentsModel>[
        CommentsModel(
          title: 'Node 1.1',
        ),
        CommentsModel(title: 'Node 1.2'),
      ],
    ),
    CommentsModel(
      title: 'Root 2',
      children: <CommentsModel>[
        CommentsModel(
          title: 'Node 2.1',

        ),
        CommentsModel(title: 'Node 2.2')
      ],
    ),
  ];

  // This controller is responsible for both providing your hierarchical data
  // to tree views and also manipulate the states of your tree nodes.
  late final TreeController<CommentsModel> treeController;

  @override
  void initState() {
    super.initState();
    treeController = TreeController<CommentsModel>(
      // Provide the root nodes that will be used as a starting point when
      // traversing your hierarchical data.
      roots: commentsList,
      // Provide a callback for the controller to get the children of a
      // given node when traversing your hierarchical data. Avoid doing
      // heavy computations in this method, it should behave like a getter.
      childrenProvider: (CommentsModel node) => node.children,
    );
  }

  @override
  void dispose() {
    // Remember to dispose your tree controller to release resources.
    treeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // experiences.
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
      ),
      body: TreeView<CommentsModel>(
        // This controller is used by tree views to build a flat representation
        // of a tree structure so it can be lazy rendered by a SliverList.
        // It is also used to store and manipulate the different states of the
        // tree nodes.
        treeController: treeController,
        // Provide a widget builder callback to map your tree nodes into widgets.
        nodeBuilder: (BuildContext context, TreeEntry<CommentsModel> entry) {
          // Provide a widget to display your tree nodes in the tree view.
          //
          // Can be any widget, just make sure to include a [TreeIndentation]
          // within its widget subtree to properly indent your tree nodes.
          return MyTreeTile(
            // Add a key to your tiles to avoid syncing descendant animations.
            key: ValueKey(entry.node),
            // Your tree nodes are wrapped in TreeEntry instances when traversing
            // the tree, these objects hold important details about its node
            // relative to the tree, like: expansion state, level, parent, etc.
            //
            // TreeEntrys are short lived, each time TreeController.rebuild is
            // called, a new TreeEntry is created for each node so its properties
            // are always up to date.
            entry: entry,
            // Add a callback to toggle the expansion state of this node.
            onTap: () => treeController.toggleExpansion(entry.node),
          );
        },
      ),
    );
  }
}

// Create a widget to display the data held by your tree nodes.
class MyTreeTile extends StatelessWidget {
  const MyTreeTile({
    super.key,
    required this.entry,
    required this.onTap,
  });

  final TreeEntry<CommentsModel> entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      child: TreeIndentation(
        entry: entry,
        guide: const IndentGuide.connectingLines(indent: 48),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
          child: Row(
            children: [
              // Add a widget to indicate the expansion state of this node.
              // See also: ExpandIcon.
              Expanded(
                child: ListTile(
                  leading: CircleAvatar(),
                  title: Text(entry.node.title),
                  onTap: entry.hasChildren ? onTap : null ,
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}