// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:firebase_auth/firebase_auth.dart';

// class LoginPage extends StatefulWidget {
//   LoginPage({this.auth});
//   final BaseAuth auth;

//   @override
//   State<StatefulWidget> createState() => _LoginPageState();
// }

// enum FormType {
//   login,
//   register,
// }

// int flag = 0;
// int goToLogin = 0;

// class _LoginPageState extends State<LoginPage> {
//   final formKey = GlobalKey<FormState>();

//   String _email;
//   String _password;
//   String mobileNumber;
//   FormType _formtype = FormType.login;

//   bool validAndSave() {
//     final form = formKey.currentState;
//     if (form.validate()) {
//       form.save();
//       return true;
//     } else {
//       return false;
//     }
//   }

//   void validateAndSubmit() async {
//     if (validAndSave()) {
//       try {
//         if (_formtype == FormType.login) {
//           goToLogin = 0;
//           String userId = await widget.auth.loginAndSignin(_email, _password);
//           // AuthResult user = await _auth.signInWithEmailAndPassword(
//           //     email: _email, password: _password);
//           print('Login user: $userId');
//         } else {
//           goToLogin = 1;
//           String userId =
//               await widget.auth.createUserEmailPass(_email, _password);
//           // AuthResult user = await _auth.createUserWithEmailAndPassword(
//           //     email: _email, password: _password);
//           print('Registered user: $userId');
//           if (goToLogin == 1) {
//             flag = 1;
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     }
//   }

//   void moveToRegisterPage() {
//     formKey.currentState.reset();
//     setState(() {
//       _formtype = FormType.register;
//     });
//   }

//   void moveToLoginPage() {
//     formKey.currentState.reset();
//     setState(() {
//       _formtype = FormType.login;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         // appBar: AppBar(
//         //   title: Text('FireBase Tutorial'),
//         // ),
//         body: Center(
//           child: Container(
//             constraints: BoxConstraints.expand(),
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(
//                   'assets/background1.png',
//                 ),
//                 fit: BoxFit.cover,
//               ),
//               // child: SingleChildScrollView(
//               //   child: Container(
//               //     child: Column(
//               //       children: <Widget>[
//               //         Center(
//               //           child: Card(
//               //             child: Image.asset('assets/logo.png', height: 200, width: 200,),
//               //           ),
//               //         ),
//               //       ],
//               //     ),
//               //   ),
//               // ),
//             ),
//             child: Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 10.0),
//                   child: Card(
//                     child: Image.asset(
//                       'assets/logo.png',
//                       fit: BoxFit.cover,
//                       width: MediaQuery.of(context).size.width / 2.5,
//                       height: MediaQuery.of(context).size.width / 2.5,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   flag == 0 ? 'Login' : 'Register',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 38.0,
//                   ),
//                 ),
//                 Form(
//                   key: formKey,
//                   child: Center(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: buildInput() + buildSubmitButton(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // body: SingleChildScrollView(
//             //         child: Card(margin: EdgeInsets.only(top: 200, right: 10, left: 10.0, bottom: 10.0),shadowColor: Colors.indigo,
//             //     color: Colors.lightBlue,
//             //     elevation: 12.0,
//             //           child: Container(
//             //       padding: EdgeInsets.all(10.0),
//             //       child: Form(
//             //         key: formKey,
//             //         child: Column(
//             //           crossAxisAlignment: CrossAxisAlignment.stretch,
//             //           mainAxisAlignment: MainAxisAlignment.center,
//             //           mainAxisSize: MainAxisSize.min,
//             //           children: buildInput() + buildSubmitButton(),
//             //         ),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//           ),
//         ));
//   }

//   List<Widget> buildInput() {
//     return [
//       TextFormField(
//         style: TextStyle(color: Colors.white),
//         keyboardType: TextInputType.emailAddress,
//         validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
//         decoration: InputDecoration(
//           labelText: 'email',
//         ),
//         onSaved: (newValue) => _email = newValue,
//       ),
//       Container(
//         child: TextFormField(
//           style: TextStyle(color: Colors.white),
//           validator: (value) =>
//               value.isEmpty ? 'Password can\'t be empty' : null,
//           decoration: InputDecoration(labelText: 'password'),
//           obscureText: true,
//           onSaved: (newValue) => _password = newValue,
//         ),
//       ),
//       Container(
//         child: flag == 0
//             ? null
//             : TextFormField(
//                 style: TextStyle(color: Colors.white),
//                 validator: (value) =>
//                     value.isEmpty ? 'Password can\'t be empty' : null,
//                 decoration: InputDecoration(labelText: 'Mobile Number'),
//                 obscureText: true,
//                 onSaved: (newValue) => _password = newValue,
//               ),
//       ),
//     ];
//   }

//   List<Widget> buildSubmitButton() {
//     if (_formtype == FormType.login) {
//       // flag = 0;
//       return [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: RaisedButton(
//             color: Colors.deepPurpleAccent,
//             onPressed: validateAndSubmit,
//             child: Text(
//               'Login',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 20, bottom: 20),
//           child: FlatButton(
//             onPressed: () {
//               flag = 1;
//               moveToRegisterPage();
//             },
//             child: Text(
//               'Ceate new account',
//               style: TextStyle(fontSize: 20.0, color: Colors.white),
//             ),
//           ),
//         ),
//       ];
//     } else {
//       // flag = 1;
//       return [
//         RaisedButton(
//           color: Colors.deepPurpleAccent,
//           onPressed: validateAndSubmit,
//           child: Text(
//             'Create an account',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         FlatButton(
//           onPressed: () {
//             flag = 0;
//             moveToLoginPage();
//           },
//           child: Text(
//             'Already have an account? Login',
//             style: TextStyle(fontSize: 20.0, color: Colors.white),
//           ),
//         ),
//       ];
//     }
//   }
// }

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../auth/auth.dart';
import '../auth/authorizationProvider.dart';

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Email can\'t be empty' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
  }
}

class LoginSignupPage extends StatefulWidget {
  const LoginSignupPage({this.onSignedIn});

  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginSignupPageState();
}

enum FormType {
  login,
  register,
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<User> user; // firebase user
  Stream<Map<String, dynamic>> profile; // custom user data in Firestore
  bool isLoaded=true;

  String _email;
  String _password;
  String _name;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        final BaseAuth auth = AuthProvider.of(context).auth;
        setState(() {
          isLoaded=false;
        });
        if (_formType == FormType.login) {
          final String userId =
              await auth.signInWithEmailAndPassword(_email, _password).whenComplete(() {
                setState(() {
                  isLoaded=true;
                });
              });

          print('Signed in: $userId');
        } else {
          final String userId =
              await auth.createUserWithEmailAndPassword(_email, _password);
          await Auth().addUserDetails(_email, _name, userId);

          print('Registered user: $userId');
        }
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/img/background1.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 10.0),
                    child: Image.asset(
                      'assets/img/logo.png',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: MediaQuery.of(context).size.width / 2.5,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  _formType == FormType.login
                      ? Text(
                          'Login',
                          style: TextStyle(fontSize: 38.0, color: Colors.white),
                        )
                      : Text(
                          'Register',
                          style: TextStyle(fontSize: 38.0, color: Colors.white),
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  _formType != FormType.login
                      ? Container(
                          width: 0.8 * MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              autofocus: true,
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.center,
                              key: Key('username'),
                              decoration: InputDecoration(
                                hintText: '  Enter Name',
                                hintStyle: TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromRGBO(00, 44, 64, 1),
                                ),
                                border: InputBorder.none,
                              ),
                              validator: EmailFieldValidator.validate,
                              onSaved: (String value) => _name = value,
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 58,
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    width: 0.8 * MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        key: Key('email'),
                        decoration: InputDecoration(
                          hintText: '  Enter Email id',
                          hintStyle: TextStyle(
                            fontSize: 20.0,
                            color: Color.fromRGBO(00, 44, 64, 1),
                          ),
                          border: InputBorder.none,
                        ),
                        validator: EmailFieldValidator.validate,
                        onSaved: (String value) => _email = value,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    width: 0.8 * MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        key: Key('password'),
                        decoration: InputDecoration(
                          hintText: '  Enter Your Password',
                          hintStyle: TextStyle(
                            fontSize: 20.0,
                            color: Color.fromRGBO(00, 44, 64, 1),
                          ),
                          border: InputBorder.none,
                        ),
                        obscureText: true,
                        validator: PasswordFieldValidator.validate,
                        onSaved: (String value) => _password = value,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  _formType == FormType.login
                      ? Container(
                          width: 0.8 * MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: Colors.lime[800],
                            color: Color.fromRGBO(173, 173, 117, 1),
                          ),
                          child: FlatButton(
                            key: Key('signIn'),
                            child: isLoaded
                                ? Text('Login',
                                    style: TextStyle(fontSize: 20.0))
                                : Center(
                                    child: CircularProgressIndicator(),
                                  ),
                            onPressed: validateAndSubmit,
                          ),
                        )
                      : Container(
                          width: 0.8 * MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: Colors.lime[800],
                            color: Color.fromRGBO(173, 173, 117, 1),
                          ),
                          child: FlatButton(
                            child: isLoaded? Text('Create an account',
                                style: TextStyle(
                                  fontSize: 20.0,
                                )): Center(child: CircularProgressIndicator()),
                            onPressed: validateAndSubmit,
                          ),
                        ),
                  _formType == FormType.login
                      ? FlatButton(
                          child: Text('Create an account',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                          onPressed: moveToRegister,
                        )
                      : FlatButton(
                          child: Text('Have an account? Login',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                          onPressed: moveToLogin,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return <Widget>[
      // Container(),
      TextFormField(
        key: Key('email'),
        decoration: InputDecoration(labelText: 'Email'),
        validator: EmailFieldValidator.validate,
        onSaved: (String value) => _email = value,
      ),
      TextFormField(
        key: Key('password'),
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: PasswordFieldValidator.validate,
        onSaved: (String value) => _password = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return <Widget>[
        RaisedButton(
          key: Key('signIn'),
          child: Text('Login', style: TextStyle(fontSize: 20.0)),
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child: Text('Create an account', style: TextStyle(fontSize: 20.0)),
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return <Widget>[
        RaisedButton(
          child: Text('Create an account', style: TextStyle(fontSize: 20.0)),
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child:
              Text('Have an account? Login', style: TextStyle(fontSize: 20.0)),
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}
