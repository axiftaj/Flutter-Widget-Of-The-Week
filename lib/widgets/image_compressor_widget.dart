

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';



class ImageCompressorWidget extends StatefulWidget {
  const ImageCompressorWidget({Key? key}) : super(key: key);

  @override
  State<ImageCompressorWidget> createState() => _ImageCompressorWidgetState();
}

class _ImageCompressorWidgetState extends State<ImageCompressorWidget> {

  File? newImage ;
  XFile? image ;
  final picker = ImagePicker();

  // method to pick single image while replacing the photo
  Future imagePickerFromCamera ()async{

    image = (await picker.pickImage(source: ImageSource.gallery))!;
    final bytes = await image!.readAsBytes();

    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          imagePickerFromCamera ();
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            if(image != null )
            SizedBox(
              child: Image.file(
                File(image!.path),
                fit: BoxFit.fitHeight,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
