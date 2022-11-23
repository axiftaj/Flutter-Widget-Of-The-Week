

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:tuple/tuple.dart';

class HtmlEditor extends StatefulWidget {
  const HtmlEditor({Key? key}) : super(key: key);

  @override
  State<HtmlEditor> createState() => _HtmlEditorState();
}

enum _SelectionType {
  none,
  word,
  // line,
}


class _HtmlEditorState extends State<HtmlEditor> {

  QuillController _controller = QuillController.basic();
  final bodyFocusNode = FocusNode();
  _SelectionType _selectionType = _SelectionType.none;
  Timer? _selectAllTimer;
  bool _onTripleClickSelection() {
    final controller = _controller!;

    _selectAllTimer?.cancel();
    _selectAllTimer = null;

    // If you want to select all text after paragraph, uncomment this line
    // if (_selectionType == _SelectionType.line) {
    //   final selection = TextSelection(
    //     baseOffset: 0,
    //     extentOffset: controller.document.length,
    //   );

    //   controller.updateSelection(selection, ChangeSource.REMOTE);

    //   _selectionType = _SelectionType.none;

    //   return true;
    // }

    if (controller.selection.isCollapsed) {
      _selectionType = _SelectionType.none;
    }

    if (_selectionType == _SelectionType.none) {
      _selectionType = _SelectionType.word;
      _startTripleClickTimer();
      return false;
    }

    if (_selectionType == _SelectionType.word) {
      final child = controller.document.queryChild(
        controller.selection.baseOffset,
      );
      final offset = child.node?.documentOffset ?? 0;
      final length = child.node?.length ?? 0;

      final selection = TextSelection(
        baseOffset: offset,
        extentOffset: offset + length,
      );

      controller.updateSelection(selection, ChangeSource.REMOTE);

      // _selectionType = _SelectionType.line;

      _selectionType = _SelectionType.none;

      _startTripleClickTimer();

      return true;
    }

    return false;
  }

  void _startTripleClickTimer() {
    _selectAllTimer = Timer(const Duration(milliseconds: 900), () {
      _selectionType = _SelectionType.none;
    });
  }
   var length ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    _controller.addListener(() {


      setState(() {

      });
    }) ;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(length.toString()),
            Text((_controller.plainTextEditingValue.text.length-1).toString()),
            Text(_controller.selection.baseOffset.toString()),
            Text(_controller.selection.extentOffset.toString()),
            Text(_controller.selection.base.toString()),

            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8)
                  )
              ),
              child: QuillToolbar.basic(controller: _controller ),
            ),
            Container(
              height: 200,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8)
                  )

              ),
              child: Theme(
                data: ThemeData.dark(),
                child: MouseRegion(
                  cursor: SystemMouseCursors.text,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15 , top: 15, bottom: 20),
                    child: QuillEditor(
                      controller: _controller!,
                      scrollController: ScrollController(),
                      scrollable: true,
                      focusNode: bodyFocusNode,
                      autoFocus: false,//
                      readOnly: false,

                      enableInteractiveSelection: true,
                    //  placeholder: 'Enter text',
                      enableSelectionToolbar: false,

                      expands: false,
                      padding: EdgeInsets.zero,
                      onTapUp: (details, p1) {
                        return _onTripleClickSelection();
                      },

                      customStyles: DefaultStyles(
                        color: Colors.red,

                        placeHolder: DefaultTextBlockStyle(
                            Theme.of(context).textTheme.headline5!.copyWith(
                                height: 0,
                                fontSize: 16),
                            const Tuple2(8, 0),
                            const Tuple2(0, 0),
                            null),
                        bold: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold , height: 0),
                        italic: const TextStyle(color: Colors.black,  height: 0 , fontStyle: FontStyle.italic),
                        paragraph: DefaultTextBlockStyle(
                            Theme.of(context).textTheme.headline5!.copyWith(
                                height: 0,
                                fontSize: 20, ),
                            const Tuple2(8, 0),
                            const Tuple2(0, 0),
                            null),

                      ),

                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
