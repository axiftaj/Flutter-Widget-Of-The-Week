import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class MathAiScreen extends StatefulWidget {
  const MathAiScreen({super.key});

  @override
  State<MathAiScreen> createState() => _MathAiScreenState();
}

class _MathAiScreenState extends State<MathAiScreen> {

  File? newImage ;
  XFile? image ;
  final picker = ImagePicker();

  // method to pick single image while replacing the photo
  Future imagePickerFromGallery ()async{

    image = (await picker.pickImage(source: ImageSource.gallery))!;

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image!.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio16x9,
            CropAspectRatioPreset.ratio5x4,
        //    CropAspectRatioPresetCustom(),
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          //  CropAspectRatioPresetCustom(), // IMPORTANT: iOS supports only one custom aspect ratio in preset list
          ],
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    newImage = File(croppedFile!.path) ;

    setState(() {});

  }


  Future<void> sendImage(File imageFile)async{
    String base64Image = base64Encode(imageFile.readAsBytesSync());
     String apiKey = 'AIzaSyCNPXTgr6aDQyy2GJgunSUdaLJ7gF1rwpg';

    String requestBody = json.encode(
        {
          "contents": [
            {
              "role": "user",
              "parts": [
                {
                  "fileData": {
                    "fileUri": base64Image,
                    "mimeType": "image/png"
                  }
                },
                {
                  "text": "Solve this mathematic equation and write step by step details and reason behind that step ? "
                }
              ]
            },
            {
              "role": "model",
              "parts": [
                {
                  "text": "The given equation is the quadratic formula. This formula is used to find the solutions (also called roots) of a quadratic equation in the form ax² + bx + c = 0. Here'\''s how it works:\\n\\n**1. Identify the Coefficients:**\\n\\n*  The quadratic equation is in the form ax² + bx + c = 0.\\n* Identify the coefficients '\''a'\'', '\''b'\'', and '\''c'\'' from the given equation.\\n\\n**2. Substitute the Values into the Quadratic Formula:**\\n\\n* The quadratic formula is: \\n   x = (-b ± √(b² - 4ac)) / 2a \\n\\n* Substitute the values of '\''a'\'', '\''b'\'', and '\''c'\'' into the formula.\\n\\n**3. Simplify the Expression:**\\n\\n*  Calculate the value inside the square root (b² - 4ac). This is called the discriminant.\\n*  Calculate the rest of the expression, simplifying as needed.\\n\\n**4. Find the Solutions:**\\n\\n*  The quadratic formula will give you two solutions, one with a plus sign (+) and one with a minus sign (-) before the square root. These solutions are the roots of the quadratic equation.\\n\\n**Example:**\\n\\nLet'\''s say you have the quadratic equation 2x² + 5x - 3 = 0.\\n\\n* a = 2, b = 5, c = -3\\n\\nSubstituting into the quadratic formula:\\n\\nx = (-5 ± √(5² - 4 * 2 * -3)) / (2 * 2)\\nx = (-5 ± √(49)) / 4\\nx = (-5 ± 7) / 4\\n\\nTherefore, the solutions are:\\n\\n* x1 = (-5 + 7) / 4 = 1/2\\n* x2 = (-5 - 7) / 4 = -3 \\n\\n**Important Note:**\\n\\nThe quadratic formula can be used to solve any quadratic equation, even if the discriminant (b² - 4ac) is negative. If the discriminant is negative, the solutions will be complex numbers.\\n"
                }
              ]
            },
            {
              "role": "user",
              "parts": [
                {
                  "text": "INSERT_INPUT_HERE"
                }
              ]
            }
          ],
          "generationConfig": {
            "temperature": 1,
            "topK": 64,
            "topP": 0.95,
            "maxOutputTokens": 8192,
            "responseMimeType": "text/plain"
          },
          "safetySettings": [
            {
              "category": "HARM_CATEGORY_HARASSMENT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_HATE_SPEECH",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            }
          ]
        }
    );

    final response = await http.post(Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${apiKey}'),
    headers: {"Content-Type": "application/json"} ,
    body: requestBody
    );
    
    if(response.statusCode == 200){
      print(response.body);
    }else {
      print('failed');
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          imagePickerFromGallery();
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            if(image != null )
              SizedBox(
                child: Image.file(
                  File(newImage !.path),
                  fit: BoxFit.fitHeight,
                ),
              ),

          ],
        ),
      ),
    );
  }
}


