import 'package:android_intent/android_intent.dart';
import'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:user/models/categories_enum.dart';
import 'package:user/widgets/appbar_subcategory_screens.dart';
import 'package:user/widgets/loading_bar.dart';
import 'package:user/widgets/sanitizer_vendor_list_item.dart';

class SanitizeVendorListScreen extends StatefulWidget {
  final Cards category;
  SanitizeVendorListScreen(this.category);

  @override
  _SanitizeVendorListScreenState createState() => _SanitizeVendorListScreenState();
}

class _SanitizeVendorListScreenState extends State<SanitizeVendorListScreen> {
  String collectionName = '';

  final PermissionHandler permissionHandler = PermissionHandler();

  Map<PermissionGroup, PermissionStatus> permissions;

  Future<bool> requestLocationPermission({Function onPermissionDenied}) async {
    var granted = await _requestPermission(PermissionGroup.location);
    if (granted!=true) {
      requestLocationPermission();
    }
    debugPrint('requestContactsPermission $granted');
    return granted;
  }

  Future<bool> _requestPermission(PermissionGroup permission) async {
    final PermissionHandler _permissionHandler = PermissionHandler();
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future _checkGps() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Can't get gurrent location"),
                content:const Text('Please make sure you enable GPS and try again'),
                actions: <Widget>[
                  FlatButton(child: Text('Ok'),
                      onPressed: () {
                        final AndroidIntent intent = AndroidIntent(
                            action: 'android.settings.LOCATION_SOURCE_SETTINGS');
                        intent.launch();
                        Navigator.of(context, rootNavigator: true).pop();
                        _gpsService();
                      })],
              );
            });
      }
    }
  }

  Future _gpsService() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      _checkGps();
      return null;
    } else
      return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestLocationPermission();
    _gpsService();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.category == Cards.sanitize)
      collectionName = 'vendorSanitize';
    else if (widget.category == Cards.cockroach)
      collectionName = 'vendorCockroach';
    else if (widget.category == Cards.mosquito) collectionName = 'vendorMosquito';

    return Scaffold(
      appBar: UniversalAppBar(context,false,"Vendor List"),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection(collectionName).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return LoadingBar();
          else {
            return ListView.builder(
                itemCount: snapshot.data.docs.length == 0
                    ? 0
                    : snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return SanitizerVendorListItem(
                      vendorName: snapshot.data.docs[index].data()['name'],
                      location: snapshot.data.docs[index].data()['location'],
                      pricePerFeet:
                          snapshot.data.docs[index].data()['pricePerFeet'].toString(),
                      category: widget.category,
                      uid: snapshot.data.docs[index].data()['uid']);
                });
          }
        },
      ),
    );
  }
}
