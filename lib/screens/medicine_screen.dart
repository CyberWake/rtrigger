import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import "package:image_picker/image_picker.dart";
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:user/widgets/appbar_subcategory_screens.dart';
import 'package:user/widgets/search.dart';

final Color _color = Color.fromRGBO(0, 44, 64, 1);

class MedicineScreen extends StatefulWidget {
  @override
  _MedicineScreenState createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  bool loading = false;
  String line1 = "";
  String line2 = "";
  String line3 = "";
  bool attachment = false;
  File _image;
  final picker = ImagePicker();
  var pickedFile;
  Future getImage() async {
    Navigator.pop(context);
//    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() async {
      if (pickedFile == null) {
        pickedFile = picker.getImage(source: ImageSource.camera);
        attachment = true;
      }
      _image = File(pickedFile.path);
    });
  }

  getGallery() async {
//    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() async {
      if (pickedFile == null) {
        pickedFile = picker.getImage(source: ImageSource.gallery);
        attachment = true;
      }
      _image = File(pickedFile.path);
    });
  }

  getDoc() async {
    _image = await FilePicker.getFile();
  }

  void submit(BuildContext ctx) async {
    var url;
    setState(() {
      loading = true;
    });
    if (_image != null) {
      String userId = (await FirebaseAuth.instance.currentUser).uid;
      print(userId);
      print('------------');
      final store = FirebaseStorage.instance
          .ref()
          .child('user_medical_images')
          .child(userId + '.jpg');
      print('------------');
      await store.putFile(_image).onComplete;
      print('------------');
      url = await store.getDownloadURL();
    }
    print('------------');
    setState(() {
      loading = false;
      _image = null;
    });
  }

  Widget button() {
    return PopupMenuButton(
        icon: Icon(
          Icons.attachment,
          color: _color,
          size: MediaQuery.of(context).size.height * 0.05,
        ),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                          icon: Icon(Icons.image),
                          onPressed: () async {
                            await getGallery();
                          }),
                      Text('Image '),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          icon: Icon(Icons.file_upload), onPressed: getDoc),
                      Text('Doc '),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          icon: Icon(Icons.photo_camera), onPressed: getImage),
                      Text('Camera'),
                    ],
                  ),
                ],
              ),
            )
          ];
        },
        onSelected: (_) {});
  }

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    double y = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      appBar: UniversalAppBar(context, false, "Medicine"),
        body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: x * 0.15),
            child: Container(
              width: w,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 0.0, bottom: y * 0.013),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: x * 0.01, right: x * 0.018),
                          child: FlatButton.icon(
                            onPressed: () {
                              print("hi");
                              //Navigator.of(context).push(MaterialPageRoute(builder: (_) => Filter(medicine_list)));
                            },
                            icon: Icon(
                              Icons.filter_list,
                              color: _color,
                              size: y * 0.03,
                            ),
                            label: Text(
                              'Filter',
                              style: TextStyle(color: _color),
                            ),
                          ),
                        ),
                        Search(),
                        Padding(
                          padding: EdgeInsets.only(left: x * 0.01),
                          child: IconButton(
                            icon: Icon(Icons.add_shopping_cart),
                            color: _color,
                            iconSize: y * 0.03,
                            onPressed: () {
                              /*Cart_list.add({
                                  'id' : line1,
                                  'loc' : 'images/ii.png',
                                  'sum' : 100,
                                  'count' : 1,
                                });
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => Cart()));*/
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Text('Medical Shop Name',
                      style: TextStyle(
                          color: _color,
                          fontSize: y * 0.033,
                          fontWeight: FontWeight.bold)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: y * 0.02),
                    child: Text(
                      '1 km from your location',
                      style: TextStyle(color: _color, fontSize: y * 0.018),
                    ),
                  ),
                  Text(
                    'Home Delivery available',
                    style: TextStyle(
                        color: _color,
                        fontWeight: FontWeight.w600,
                        fontSize: y * 0.018),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: y * 0.02),
                    child: Text(
                      'Upload the picture or the document list of things needed',
                      style: TextStyle(color: _color, fontSize: y * 0.019),
                    ),
                  ),
                  /* Container(
                        alignment: Alignment.center,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: ShapeDecoration(
                            color: Colors.teal.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Upload',
                                style: TextStyle(
                                    color: _color,
                                    fontSize: MediaQuery.of(context).size.height *
                                        0.018),
                              ),
                              if (_image == null)
                                button
                              else
                                Text(
                                  'Complete',
                                  style: TextStyle(
                                      color: _color, fontSize: y * 0.026),
                                ),
                            ],
                          ),
                        ),
                      ),*/
                  Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: y * 0.02, bottom: 0.0),
                      child: Text('Or Type the name of medicine'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: y * 0.02),
                    alignment: Alignment.center,
                    child: Container(
                      width: x * 0.6,
                      height: y * 0.07,
                      padding: EdgeInsets.symmetric(horizontal: x * 0.02),
                      //width: 275,
                      decoration: ShapeDecoration(
                        color: Colors.teal.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Upload Prescription',
                            style: TextStyle(
                              color: _color,
                              fontSize: y * 0.022,
                            ),
                          ),
                          attachment
                              ? IconButton(
                                  icon: Icon(Icons.attachment,
                                      color: _color, size: 25),
                                  onPressed: () {
                                    button;
                                  },
                                )
                              : Text(
                                  'Completed',
                                  style: TextStyle(
                                      color: _color, fontSize: y * 0.022),
                                ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: x * 0.0875, right: x * 0.0875),
                    child: Column(
                      children: [
                        TextField(
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
                          onChanged: (val) {
                            line1 = val.trim();
                            print(val);
                          },
                          maxLines: 8,
                        ),
                        TextField(
                          minLines: 1,
                          onChanged: (val) {
                            line2 = val.trim();
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: 8,
                        ),
                        TextField(
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
                          maxLines: 8,
                          onChanged: (val) {
                            line1 = val.trim();
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: y * 0.011),
                    child: Container(
                      alignment: Alignment.center,
                      child: Container(
                        height: y * 0.05,
                        width: x / 4,
                        child: RaisedButton(
                          onPressed: () {
                            submit(context);
                          },
                          child: loading
                              ? Container(
                                  height: 10,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  ))
                              : Text("Save",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.height * 0.02,
                                  )),
                          color: Color.fromRGBO(00, 44, 64, 1.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
