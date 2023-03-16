

import 'dart:io';
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

    image = (await picker.pickImage(source: ImageSource.camera))!;
    final bytes = await image!.readAsBytes();

    //converting image size to
    // final kb = bytes.length / 1024;
    // final mb = kb / 1024;


    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = dir.absolute.path + '/temp.jpg';


    final result = await FlutterImageCompress.compressAndGetFile(
      image!.path,
      targetPath,
      minHeight: 1080, //you can play with this to reduce siz
      minWidth: 1080,
      quality: 90, // keep this high to get the original qualit if image
    );


    final newKb = result!.readAsBytesSync().length / 1024;
    final newMb = newKb / 1024;

    newImage = result;

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
                File(newImage!.path),
                fit: BoxFit.fitHeight,
              ),
            ),
            TextButton(onPressed: (){
              
            }, child: const Text('Compress'))

          ],
        ),
      ),
    );
  }
}
