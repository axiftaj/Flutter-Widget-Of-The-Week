



import 'package:flutter/material.dart';

class InteractiveViewerWidget extends StatelessWidget {
  const InteractiveViewerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Viewer widget'),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 1,
          maxScale: 10,
          child: Image.network(
              'https://scontent.fisb5-1.fna.fbcdn.net/v/t39.30808-6/379453287_5109356982629026_6158747720213286071_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=a2f6c7&_nc_ohc=dgPUW1hwvnsAX_GvrO6&_nc_ht=scontent.fisb5-1.fna&oh=00_AfApvO2e_V2O6e4DsqdCS7oh6E9qkK1xf8ZpE4ax3OFnwQ&oe=6521ED3C'
          ),
        ),
      ),
    );
  }
}
