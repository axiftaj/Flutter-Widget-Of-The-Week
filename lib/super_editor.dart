


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zefyrka/zefyrka.dart';

class SuperEditor extends StatefulWidget {
  const SuperEditor({Key? key}) : super(key: key);

  @override
  State<SuperEditor> createState() => _SuperEditorState();
}

class _SuperEditorState extends State<SuperEditor> {

  ZefyrController _controller = ZefyrController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    focusNode.dispose();
    _controller.dispose() ;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 40),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(),
                  SizedBox(height: 100,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ZefyrField(
                        focusNode: focusNode,
                        padding: EdgeInsets.zero,
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Asif Taj' ,
                        ),
                        toolbar: ZefyrToolbar.basic(controller: _controller),
                      ),
                    ),
                  ),
                  SizedBox(height: 100,),
                  TextButton(onPressed: (){

                  }, child: Text('Next'))

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
