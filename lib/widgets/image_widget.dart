

import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ImageBuilderWidget(image: 'https://images.pexels.com/photos/13585848/pexels-photo-13585848.jpeg?cs=srgb&dl=pexels-bruno-silva-13585848.jpg&fm=jpg',),
      ),
    );
  }
}


class ImageBuilderWidget extends StatelessWidget {

  final String image ;
  final double height, width ;
  const ImageBuilderWidget({Key? key,required this.image ,  this.height = 200 , this.width = 200 }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
            )
        ),
        child: ClipRRect(
          child: Image(
            fit: BoxFit.cover,
            height: height,
            width: width,
            repeat: ImageRepeat.repeatY,
            image:  NetworkImage(image),
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Container(
                  height: height,
                  width: width,
                  child: const Icon(
                    Icons.error,
                    color: Colors.red,
                  ));
            },
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child ;
              return SizedBox(
                height: height,
                width: width,
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}