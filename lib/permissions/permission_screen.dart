import 'package:asif/permissions/permission_services.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';



class PermissionScreen extends StatelessWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(onPressed: (){
                final permisison  =  CameraPermission();

                permisison.requestPermission().then((value){
                  if(value.isPermanentlyDenied){
                  //  permisison.openAppSettingsForTheCameraPermission();
                  }
                });

              }, child: Text('Camera Permissin'))
            ],
          ),
        ),
      ),
    );
  }
}
