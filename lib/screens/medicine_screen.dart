import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import "package:image_picker/image_picker.dart";
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:user/auth/auth.dart';
import 'package:user/models/profile.dart';
import 'package:user/screens/medical_bargain_screen.dart';
import 'package:user/widgets/appbar_subcategory_screens.dart';
import 'package:user/widgets/search.dart';

final Color _color = Color.fromRGBO(0, 44, 64, 1);

class MedicineScreen extends StatefulWidget {
  final String vendorName;
  final double kmFar;
  final String location;
  final String uid;

  MedicineScreen(
      {@required this.vendorName,
      @required this.kmFar,
      @required this.location,
      @required this.uid});

  @override
  _MedicineScreenState createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  final GlobalKey _menuKey = new GlobalKey();
  final _collectionName = 'medicalTemp';
  bool loading = false;
  bool attachment = false;
  bool isLoading =true;
  File _image;
  final picker = ImagePicker();
  var pickedFile;
  final instructionController = TextEditingController();
  Auth auth = Auth();
  UserProfile profile;
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
      final store = FirebaseStorage.instance
          .ref()
          .child('user_medical_images')
          .child(userId + '.jpg');
      await store.putFile(_image).onComplete;
      url = await store.getDownloadURL();
      print(url);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MedicalBargainScreen(
                url: url,
                name: widget.vendorName,
                location: widget.location,
                description: instructionController.text,
                uid: widget.uid,
              )));
    }
    setState(() {
      loading = false;
      _image = null;
    });
  }

  void _button(Offset offset) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(left, top, 0, 0),
        items: [
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
        ]);
  }
  @override
  void initState() {
    // TODO: implement initState
    auth.getProfile().whenComplete(() {
      profile = auth.profile;
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    double y = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      appBar: UniversalAppBar(context, false, "Medicine"),
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width / 8),
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.vendorName,
                  style: TextStyle(
                      color: _color,
                      fontSize: y * 0.033,
                      fontWeight: FontWeight.bold)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: y * 0.02),
                child: Text(
                  '${widget.kmFar} km from your location',
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
                          ? Text(
                              'Completed',
                              style:
                                  TextStyle(color: _color, fontSize: y * 0.022),
                            )
                          : GestureDetector(
                              child: Icon(Icons.attachment,
                                  color: _color, size: 25),
                              onTapDown: (TapDownDetails details) {
                                _button(details.globalPosition);
                              },
                            )
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: y * 0.05, bottom: 0.0),
                  child: Text('Extra Instructions (If Any)'),
                ),
              ),
              TextField(
                controller: instructionController,
                minLines: 3,
                keyboardType: TextInputType.multiline,
                maxLines: 8,
              ),
              Padding(
                padding: EdgeInsets.only(top: y * 0.011),
                child: Container(
                  alignment: Alignment.center,
                  child: Container(
                    height: y * 0.08,
                    width: x / 2,
                    margin: EdgeInsets.only(top: 20),
                    child: RaisedButton(
                      onPressed: () {
                        submit(context);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                            MedicalBargainScreen(
                              name: profile.username.toString(),
                              uid: profile.userId.toString(),

                            )));
                      },
                      child: loading
                          ? Container(
                              height: 10,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ))
                          : Text("Submit Request",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
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
    );
  }
}
