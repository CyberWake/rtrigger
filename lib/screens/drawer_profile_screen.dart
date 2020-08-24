import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/auth/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:user/models/profile.dart';
import 'package:user/widgets/appbar_subcategory_screens.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File file;
  Auth auth = Auth();
  UserProfile profile;
  String url = "";
  String fileName = '';
  String newName = "";
  String address = "";
  int phoneno = 0;
  bool isLoaded = true;
  bool isLoading = true;

  void validateAndSave() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      return;
    }
    form.save();
    try {
      setState(() {
        isLoaded = false;
      });
      await auth.updateProfile(UserProfile(
          email: profile.email,
          userId: profile.userId,
          username: newName.isEmpty ? profile.username : newName,
          imageUrl: url.isEmpty ? profile.imageUrl : url,
          phone: phoneno == 0 ? profile.phone : phoneno,
          address: address.isEmpty ? profile.address : address));
      setState(() {
        isLoaded = true;
      });
    } catch (error) {
      await showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('An ERROR occured!!!'),
                content: Text('Something went Wrong'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(_).pop();
                    },
                  ),
                ],
              ));
    }
  }

  @override
  void initState() {
    auth.getProfile().whenComplete(() {
      profile = auth.profile;
      url = profile.imageUrl;
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UniversalAppBar(context,false,"profile"),
      body: SingleChildScrollView(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      child: Hero(
                        tag: url,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(url != profile.imageUrl
                                    ? url
                                    : profile.imageUrl),
                                fit: BoxFit.fill,
                              )),
                        ),
                      ),
                      onTap: () async {
                        file = await FilePicker.getFile(type: FileType.any);
                        fileName = path.basename(file.path);
                        setState(() {
                          fileName = path.basename(file.path);
                        });
                        StorageReference storageReference = FirebaseStorage
                            .instance
                            .ref()
                            .child("images/$fileName");
                        StorageUploadTask uploadTask =
                            storageReference.putFile(file);

                        final StorageTaskSnapshot downloadUrl =
                            (await uploadTask.onComplete);
                        url = (await downloadUrl.ref.getDownloadURL());
                        setState(() async {
                          url = (await downloadUrl.ref.getDownloadURL());
                        });
                      }, // <-- user image
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: EdgeInsets.all(15),
                        child: Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            Text(
                              profile.email,
                              style: TextStyle(fontSize: 25),
                            ),
                            TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Username'),
                                initialValue: profile.username,
                                autofocus: true,
                                onSaved: (value) {
                                  newName = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter a username';
                                  }
                                  return null;
                                }),
                            TextFormField(
                                decoration: InputDecoration(labelText: 'Phone'),
                                initialValue: profile.phone.toString(),
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                onSaved: (value) {
                                  phoneno = int.parse(value);
                                },
                                validator: (value) {
                                  if (value.isEmpty ||
                                      int.parse(value) < 6000000000 ||
                                      int.parse(value) > 9999999999) {
                                    return 'Please enter valid phone number';
                                  }
                                  return null;
                                }),
                            TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Address'),
                                initialValue: profile.address,
                                autofocus: true,
                                keyboardType: TextInputType.multiline,
                                onSaved: (value) {
                                  address = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter a valid address.';
                                  }
                                  return null;
                                }),
                          ]),
                        )),
                    isLoaded
                        ? RaisedButton(
                            color: Colors.purple,
                            child: Text(
                              "Update info",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            onPressed: validateAndSave,
                          )
                        : CircularProgressIndicator()
                  ],
                ),
              ),
      ),
    );
  }
}
