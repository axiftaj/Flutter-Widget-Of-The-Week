
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:file_picker/file_picker.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  String result = '';
  final HtmlEditorController controller = HtmlEditorController(processNewLineAsBr: true);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!kIsWeb) {
          controller.clearFocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('sadf'),
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  if (kIsWeb) {
                    controller.reloadWeb();
                  } else {
                    controller.editorController!.reload();
                  }
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.toggleCodeView();
          },
          child: Text(r'<\>', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(result.length.toString()),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(7)
                ),
                child: HtmlEditor(
                  controller: controller,
                  htmlEditorOptions: const HtmlEditorOptions(
                    hint: 'Your text here...',
                   // initialText: "<p>text content initial, if any</p>",
                  ),
                  htmlToolbarOptions: HtmlToolbarOptions(
                    defaultToolbarButtons: [
                      FontSettingButtons(fontName: false , fontSizeUnit: false),
                      FontButtons(strikethrough: false, subscript: false , superscript: false),
                      ListButtons(listStyles: false),
                      StyleButtons(style: false),

                    ],
                    toolbarPosition: ToolbarPosition.belowEditor, //by default
                    toolbarType: ToolbarType.nativeScrollable, //by default
                    onButtonPressed: (ButtonType type, bool? status, Function? updateStatus) {
                      print("button '${describeEnum(type)}' pressed, the current selected status is $status");
                      return true;
                    },
                    onDropdownChanged: (DropdownType type, dynamic changed,
                        Function(dynamic)? updateSelectedItem) {
                      print("dropdown '${describeEnum(type)}' changed to $changed");
                      return true;
                    },

                  ),
                  otherOptions: OtherOptions(height: 200 ,
                  decoration: BoxDecoration(
                  //  color: Colors.blue
                  )
                  ),
                  callbacks: Callbacks(onBeforeCommand: (String? currentHtml) {
                    print('html before change is $currentHtml');
                  }, onChangeContent: (String? changed)async {
                    print('content changed to $changed');


                  }, onChangeCodeview: (String? changed) {
                    print('code changed to $changed');
                  }, onChangeSelection: (EditorSettings settings) {
                    print('parent element is ${settings.parentElement}');
                    print('font name is ${settings.fontName}');
                  }, onDialogShown: () {
                    print('dialog shown');
                  }, onEnter: () {
                    print('enter/return pressed');
                  }, onFocus: () {
                    print('editor focused');
                  }, onBlur: () {
                    print('editor unfocused');
                  }, onBlurCodeview: () {
                    print('codeview either focused or unfocused');
                  }, onInit: () {
                    print('init');
                  },

                      onKeyUp: (int? keyCode) {
                        print('$keyCode key released');
                      }, onMouseDown: () {
                        print('mouse downed');
                      }, onMouseUp: () {
                        print('mouse released');
                      }, onNavigationRequestMobile: (String url) {
                        print(url);
                        return NavigationActionPolicy.ALLOW;
                      }, onPaste: () {
                        print('pasted into editor');
                      }, onScroll: () {
                        print('editor scrolled');
                      }),
                  plugins: [
                    SummernoteAtMention(
                        getSuggestionsMobile: (String value) {
                          var mentions = <String>['test1', 'test2', 'test3'];
                          return mentions
                              .where((element) => element.contains(value))
                              .toList();
                        },
                        mentionsWeb: ['test1', 'test2', 'test3'],
                        onSelect: (String value) {
                          print(value);
                        }),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }


}