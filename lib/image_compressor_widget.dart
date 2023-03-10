

import 'dart:io';

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
  Future replacePhotoPickImage ()async{

    image = (await picker.pickImage(source: ImageSource.camera))!;
    final bytes = await image!.readAsBytes();

    final kb = bytes.length / 1024;
    final mb = kb / 1024;

    print(mb);

    // final result = await FlutterImageCompress.compressAndGetFile(
    //     image!.path,
    //   image!.path.toString()+"tem/jpg",
    //   quality: 80,
    //   rotate: 180,
    // );

    final result = await FlutterImageCompress.compressAndGetFile(
      image!.path,
      quality: 90,
    );
    print('after = ${result!.length}');

    // final newKb = result.lengthInBytes / 1024;
    // final newMb = newKb / 1024;
    // print(newMb);
    //
    // newImage = File(path).writeAsBytes(bytes);

   // newImage = File(image!.path);
    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          replacePhotoPickImage ();
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            if(image != null )
            SizedBox(
              height: 200,
              child: Image.file(
                File(newImage!.path),
                fit: BoxFit.cover,
              ),
            ),
            TextButton(onPressed: (){
              
            }, child: Text('Compress'))

          ],
        ),
      ),
    );
  }
}
