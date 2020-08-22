import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/auth/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _profile;
  File file;
  String url = "";
  String fileName = '';
  String newName = "";
  String address = "";
  int phoneno = 0;
  bool isLoaded = true;

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
      await Auth().updateProfile(
          email: _profile['email'],
          uid: _profile['userId'],
          username: newName.isEmpty ? _profile['username'] : newName,
          url: url.isEmpty ? _profile['imageUrl'] : url,
          phone: phoneno == 0 ? _profile['phone'] : phoneno,
          address: address.isEmpty ? _profile['address'] : address);
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
    } finally {
      setState(() {
        isLoaded = true;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _profile = Auth().getProfile() as Map<String, dynamic>;
    setState(() {

    });
    super.didChangeDependencies();
  }

  //name,email,image,address, phone

  @override
  Widget build(BuildContext context) {
    getProfileData();
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                url,
                fit: BoxFit.fill,
              ),
            ),
            onTap: () async {
              file = await FilePicker.getFile(type: FileType.any);
              fileName = path.basename(file.path);
              StorageReference storageReference = FirebaseStorage.instance
                  .ref()
                  .child("images/$fileName");
              StorageUploadTask uploadTask =
              storageReference.putFile(file);

              final StorageTaskSnapshot downloadUrl =
              (await uploadTask.onComplete);
              url = (await downloadUrl.ref.getDownloadURL());
            }, // <-- user image
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                  key: _formKey,
                  child: ListView(children: <Widget>[
                    Text(
                      "Email id: " + _profile['email'],
                      style: TextStyle(fontSize: 30),
                    ),
                    TextFormField(
                        decoration:
                        InputDecoration(labelText: 'Username'),
                        initialValue: _profile['username'],
                        textInputAction: TextInputAction.next,
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
                        initialValue: _profile['phone'],
                        textInputAction: TextInputAction.next,
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
                        decoration: InputDecoration(labelText: 'Address'),
                        initialValue: _profile['address'],
                        textInputAction: TextInputAction.next,
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
                  ]))),
          isLoaded == true
              ? RaisedButton(
            child: Text("Update info"),
            onPressed: validateAndSave,
          )
              : CircularProgressIndicator()
        ],
      ),
    );
  }
}
