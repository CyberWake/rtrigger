import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/auth/auth.dart';
import 'package:user/auth/authorizationProvider.dart';
import 'package:user/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({this.onSignedIn});

  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

enum FormType {
  login,
  register,
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoaded = true;
  String _email;
  String _password;
  String _name;
  int _phone;
  bool c1 = true;
  bool c2 = true;
  bool c3 = true;
  bool c4 = true;

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> validateAndSubmit(BuildContext context) async {
    if (validateAndSave()) {
      final BaseAuth auth = AuthProvider.of(context).auth;
      setState(() {
        isLoaded = false;
      });
      try {
        await auth
            .createUserWithEmailAndPassword(_email, _password, _name, _phone)
            .then((value) async {
          setState(() {
            isLoaded = true;
          });
          if (value == 'email-already-in-use') {
            await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text('An Error occurred '),
                      content: Text('Entered email is already in use'),
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
            await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text('Verify your Email id'),
                      content: Text('Check your emails and verify your id.'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Okay'),
                          onPressed: () {
                            Navigator.of(_).pop();
                          },
                        ),
                      ],
                    ));
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()));
            print('Registered user');
          }
        });
      } catch (e) {
        print(e);
      }
    }
  }

  void moveToLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
                    height: MediaQuery.of(context).size.height * 0.039,
                  ),
                  Text(
                    'Register',
                    style:
                        GoogleFonts.lato(fontSize: 28.0, color: Colors.white),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    width: 0.6 * MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.104,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      key: Key('username'),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5),
                        hintText: "Enter Name",
                        errorStyle: TextStyle(fontSize: 0, height: 0),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
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
                      textCapitalization: TextCapitalization.words,
                      onSaved: (String value) => _name = value,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    width: 0.6 * MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.106,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Center(
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.center,
                        key: Key('Phone no.'),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 5),
                          hintText: "Phone number",
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
                          if (value.isEmpty ||
                              int.parse(value) < 6000000000 ||
                              int.parse(value) > 9999999999) {
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
                        onSaved: (value) => _phone = int.parse(value),
                      ),
                    ),
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
                          hintText: "Email id",
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
                              c3 = false;
                            });
                          } else {
                            setState(() {
                              c3 = true;
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
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    width: 0.6 * MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.106,
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
                              c4 = false;
                            });
                          } else {
                            setState(() {
                              c4 = true;
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
                    height: MediaQuery.of(context).size.height * 0.11,
                  ),
                  Container(
                    width: 0.6 * MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.09,
                    //alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.lime[800],
                      color: Color.fromRGBO(173, 173, 117, 1),
                    ),
                    child: FlatButton(
                      child: isLoaded
                          ? Text(
                              'Create account',
                              style: GoogleFonts.lato(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.normal),
                            )
                          : Center(child: CircularProgressIndicator()),
                      onPressed: () => validateAndSubmit(context),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 0.3 * MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.09,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueGrey,
                    ),
                    child: FlatButton(
                      child: Text(
                        'Login',
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal),
                      ),
                      onPressed: moveToLogin,
                    ),
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
        child: Text('Create an account', style: TextStyle(fontSize: 20.0)),
        onPressed: () => validateAndSubmit(context),
      ),
      FlatButton(
        child: Text('Have an account? Login', style: TextStyle(fontSize: 20.0)),
        onPressed: moveToLogin,
      ),
    ];
  }
}
