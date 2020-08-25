import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/auth/auth.dart';
import 'package:user/auth/authorizationProvider.dart';
import 'package:user/screens/login_screen.dart';

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
      try{
      await auth
          .createUserWithEmailAndPassword(_email, _password, _name)
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
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()));
          print('Registered user');
        }
      });
    }catch(e){
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
                  Text(
                    'Register',
                    style: TextStyle(fontSize: 38.0, color: Colors.white),
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
                  Container(
                    width: 0.8 * MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.lime[800],
                      color: Color.fromRGBO(173, 173, 117, 1),
                    ),
                    child: FlatButton(
                      child: isLoaded
                          ? Text('Create an account',
                              style: TextStyle(
                                fontSize: 20.0,
                              ))
                          : Center(child: CircularProgressIndicator()),
                      onPressed: () => validateAndSubmit(context),
                    ),
                  ),
                  FlatButton(
                    child: Text('Have an account? Login',
                        style: TextStyle(fontSize: 20.0, color: Colors.white)),
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
