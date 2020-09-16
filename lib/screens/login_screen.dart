import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/screens/register_screen.dart';
import 'package:user/screens/root_screen.dart';
import '../auth/auth.dart';
import '../auth/authorizationProvider.dart';
import 'package:google_fonts/google_fonts.dart';

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

class LoginScreen extends StatefulWidget {
  const LoginScreen({this.onSignedIn});

  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

enum FormType {
  login,
  register,
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isLoaded = true;
  String _email;
  String _password;
  bool c1 = true;
  bool c2 = true;

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      print("Saved");
      return true;
    }
    print("Not saved");
    return false;
  }

  Future<void> validateAndSubmit(BuildContext context) async {
    if (validateAndSave()) {
      print("LOGIN");
      final BaseAuth auth = AuthProvider.of(context).auth;
      setState(() {
        isLoaded = false;
      });
      try {
        await auth
            .signInWithEmailAndPassword(_email, _password)
            .then((value) async {
          setState(() {
            isLoaded = true;
          });
          if (value == 'Not verified') {
            await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text('Entered email is not verified'),
                      content: Text('Check your mail inbox'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Okay'),
                          onPressed: () {
                            Navigator.of(_).pop();
                          },
                        ),
                      ],
                    ));
          } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => RootPage()));
            widget.onSignedIn();
          }
        });
        print('Signed in');
      } catch (error) {
        print(error);
      }
    }
  }

  void moveToRegister() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => RegisterScreen()));
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
                  'assets/img/background.png',
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
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  Text(
                    'LOGIN',
                    style:
                        GoogleFonts.lato(fontSize: 28.0, color: Colors.white),
                    //style: TextStyle(fontSize: 38.0, color: Colors.white),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    width: 0.6 * MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.106,
                    //alignment: Alignment.center,
                    //padding: EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Center(
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        key: Key('email'),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 5),
                          hintText:
                             "Enter Email ID",
                          errorStyle: TextStyle(fontSize: 0, height: 0),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 3)),
                          hintStyle: GoogleFonts.lato(
                            fontSize: 20.0,
                            color: Color.fromRGBO(00, 44, 64, 1),
                          ),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              c1 = false;
                            });
                          } else {
                            setState(() {
                              c1 = true;
                            });
                            return null;
                          }
                          return "";
                        },
                        onSaved: (String value) => _email = value,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    width: 0.6 * MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.105,
                    //alignment: Alignment.center,
                    //padding: EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Center(
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        key: Key('password'),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 5),
                          hintText: "Password",
                          errorStyle: TextStyle(fontSize: 0, height: 0),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 3)),
                          hintStyle: GoogleFonts.lato(
                            fontSize: 20.0,
                            color: Color.fromRGBO(00, 44, 64, 1),
                          ),
                          border: InputBorder.none,
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              c2 = false;
                            });
                          } else {
                            setState(() {
                              c2 = true;
                            });
                            return null;
                          }
                          return "";
                        },
                        onSaved: (String value) => _password = value,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    width: 0.6 * MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.105,
                    //alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.lime[800],
                      color: Color.fromRGBO(173, 173, 117, 1),
                    ),
                    child: FlatButton(
                      child: isLoaded
                          ? Text(
                              'Login',
                              style: GoogleFonts.lato(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal),
                            )
                          : Center(child: CircularProgressIndicator()),
                      onPressed: () {
                        print("Pressed");
                        validateAndSubmit(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  FlatButton(
                    child: Text(
                      'Create account',
                      style:
                          GoogleFonts.lato(fontSize: 20.0, color: Colors.white),
                    ),
                    onPressed: moveToRegister,
                  ),
                  FlatButton(
                    color: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Reset Password',
                      style:
                          GoogleFonts.lato(fontSize: 14.0, color: Colors.black),
                    ),
                    onPressed: () async {
                      print(_email);
                      try {
                        if (_email == null || _email.length < 5) {
                          showAlertDialog(context, "Error!",
                              "Please mention the E-mail Id first, this feature is only for registered accounts.");
                        } else {
                          await resetPassword(_email);
                          showAlertDialog(context, "Link Sent!",
                              "Please check your email for password reset.");
                        }
                      } catch (e) {
                        showAlertDialog(context, "Error!", e.toString());
                      }
                    },
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
    return <Widget>[
      RaisedButton(
        key: Key('signIn'),
        child: Text('Login', style: TextStyle(fontSize: 20.0)),
        onPressed: () => validateAndSubmit(context),
      ),
      FlatButton(
        child: Text('Create an account', style: TextStyle(fontSize: 20.0)),
        onPressed: moveToRegister,
      ),
    ];
  }

  showAlertDialog(BuildContext context, String title, String message) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
