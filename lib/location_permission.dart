


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationPermissionWidget extends StatefulWidget {
  const LocationPermissionWidget({Key? key}) : super(key: key);

  @override
  State<LocationPermissionWidget> createState() => _LocationPermissionWidgetState();
}

class _LocationPermissionWidgetState extends State<LocationPermissionWidget> {


    /*  iPhone Permissions
    * Permission you need to add inorder to get run timer permission
    * This is the message that will show in the app for ios
    * Add this into you info.plist file file
    * */
  // <key>NSLocationAlwaysAndWhenInUsageDescription</key>
  // <string>App app want's to access your location to get address</string>
  // <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
  // <string>App app want's to access your location to get address.</string>
  // <key>NSLocationAlwaysUsageDescription</key>
  // <string>App app want's to access your location to get address.</string>
  // <key>NSLocationWhenInUseUsageDescription</key>
  // <string>App want's to access your location to get address.</string>

  /*  Android Permissions
    * Permission you need to add inorder to get run timer permission
    * Add this into your android main manifest file
    * */
  // <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
  // <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>

  // function to check if user has granted location permissions are
  Future<bool> requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false ;
    }

    return true ;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Request Location Permissions'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: InkWell(
            onTap: (){
              requestLocationPermission().then((value){
                if(value){
                  if (kDebugMode) {
                    print('permission granted');
                  }
                }else {
                  Geolocator.openAppSettings();
                }
              });
            },
            child: Container(
              height: 50,
              color: Colors.green,
              width: double.infinity,
              child: const Center(child: Text('Request Permission')),
            ),
          ),
        ),
      ),
    );
  }
}
