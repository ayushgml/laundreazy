// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LandingPage(title: 'Laundreazy Landing page'),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key, required this.title});
  final String title;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onVerticalDragUpdate: (details) {},
        onHorizontalDragUpdate: (details) {
          if (details.delta.direction > 0) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const UserDirection()));
          }
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(32),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/intro_img.png'),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}

class UserDirection extends StatelessWidget {
  const UserDirection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/user_direction_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            'YOU ARE A:',
            textAlign: TextAlign.center,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Color.fromRGBO(0, 0, 0, 1),
              fontFamily: 'Reem Kufi Fun',
              fontSize: 17,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 335,
            height: 66,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              color: Color.fromRGBO(158, 210, 198, 1),
            ),
            // onTap: () {
            //   Navigator.of(context).push(
            //       MaterialPageRoute(builder: (context) => const UserLogin()));
            // },
            child: GestureDetector(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ManagerLogin())),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(
                      Icons.arrow_circle_left_rounded,
                      size: 30,
                    ),
                    Text(
                      'LAUNDRY MANAGER',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Reem Kufi Fun',
                        fontSize: 22,
                        letterSpacing:
                            1 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                  ],
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Divider(
                color: Color.fromRGBO(0, 0, 0, 1),
                thickness: 1,
              ),
              Text(
                'OR',
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Reem Kufi Fun',
                  fontSize: 16,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
              Divider(
                color: Color.fromRGBO(0, 0, 0, 1),
                thickness: 1,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 335,
            height: 66,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              color: Color.fromRGBO(84, 186, 185, 1),
            ),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => StudentLogin())),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text(
                    'STUDENT',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: 'Reem Kufi Fun',
                      fontSize: 22,
                      letterSpacing:
                          1 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Icon(
                    Icons.arrow_circle_right_rounded,
                    size: 30,
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

// ignore: must_be_immutable
class ManagerLogin extends StatelessWidget {
  ManagerLogin({super.key});

  FocusNode emailInputNode = FocusNode();
  FocusNode passwordInputNode = FocusNode();

  String? validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  // ignore: unused_element
  String? validatePassword(String value) {
    String pattern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return 'Enter a valid password';
    } else {
      return null;
    }
  }

  TextEditingController emailId = TextEditingController();
  TextEditingController password = TextEditingController();

  void LoginWithFirebase(context) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailId.text, password: password.text)
        .then((value) => {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PendingLaundry()))
            })
        .catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    void openKeyboard() {
      FocusScope.of(context).requestFocus(emailInputNode);
    }

    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/manager_bg.png'),
                fit: BoxFit.fill,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'LAUNDRY / IRON MANAGER',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Reem Kufi Fun',
                        fontSize: 22,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1),
                  ),
                  Text(
                    'LOGIN',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Reem Kufi Fun',
                        fontSize: 36,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      controller: emailId,
                      validator: (value) => validateEmail(value!),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 231, 212, 158),
                          labelText: "Email ID",
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: new BorderSide(
                                width: 0, color: Color(0xFF4DB6AC)),
                          ),
                          icon: new Icon(Icons.email,
                              size: 50, color: Colors.black)),
                      // focusNode: emailInputNode,
                      // autofocus: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      controller: password,
                      validator: (value) => validatePassword(value!),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 231, 212, 158),
                        labelText: "Password",
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                        ),
                        icon:
                            new Icon(Icons.lock, size: 50, color: Colors.black),
                      ),
                      // focusNode: passwordInputNode,
                      // autofocus: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 335,
                        height: 66,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        child: GestureDetector(
                          onTap: () => LoginWithFirebase(context),
                          // Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //         builder: (context) => StudentHomePage())),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text(
                                'LOGIN',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Color.fromRGBO(247, 236, 222, 1),
                                  fontFamily: 'Reem Kufi Fun',
                                  fontSize: 19,
                                  letterSpacing:
                                      1 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.w400,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ManagerSignUpPage())),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              'New user? sign up here',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Reem Kufi Fun',
                                  fontSize: 16,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]))
        // ]
        );
  }
}

class ManagerSignUpPage extends StatelessWidget {
  ManagerSignUpPage({super.key});

  FocusNode emailInputNode = FocusNode();
  FocusNode passwordInputNode = FocusNode();

  String? validateName(String value) {
    if (value == null) {
      return 'Please enter your name!';
    } else {
      return null;
    }
  }

  String? validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  // ignore: unused_element
  String? validatePassword(String value) {
    String pattern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return 'Enter a valid password';
    } else {
      return null;
    }
  }

  TextEditingController emailId = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController rePassword = TextEditingController();

  void SignUpWithFirebase(context) {
    if (password.text == rePassword.text) {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailId.text, password: password.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ManagerLogin()));
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    void openKeyboard() {
      FocusScope.of(context).requestFocus(emailInputNode);
    }

    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/manager_bg.png'),
                fit: BoxFit.fill,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'STUDENT',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Reem Kufi Fun',
                        fontSize: 22,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1),
                  ),
                  Text(
                    'SIGN UP',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Reem Kufi Fun',
                        fontSize: 36,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      controller: fullName,
                      validator: (value) => validateName(value!),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(247, 236, 222, 1),
                          labelText: "Full Name",
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: new BorderSide(
                                width: 0,
                                color: Color.fromRGBO(247, 236, 222, 1)),
                          ),
                          icon: new Icon(Icons.person,
                              size: 50, color: Colors.black)),
                      // focusNode: emailInputNode,
                      // autofocus: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      controller: emailId,
                      validator: (value) => validateEmail(value!),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(247, 236, 222, 1),
                          labelText: "Email ID",
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: new BorderSide(
                                width: 0,
                                color: Color.fromRGBO(247, 236, 222, 1)),
                          ),
                          icon: new Icon(Icons.email,
                              size: 50, color: Colors.black)),
                      // focusNode: emailInputNode,
                      // autofocus: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      controller: password,
                      validator: (value) => validatePassword(value!),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(247, 236, 222, 1),
                        labelText: "Password",
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                        ),
                        icon: new Icon(Icons.lock,
                            size: 50, color: Color.fromRGBO(247, 236, 222, 1)),
                      ),
                      // focusNode: passwordInputNode,
                      // autofocus: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      controller: rePassword,
                      validator: (value) => validatePassword(value!),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(247, 236, 222, 1),
                        labelText: "re-enter Password",
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                        ),
                        icon: new Icon(Icons.lock_open,
                            size: 50, color: Color.fromRGBO(247, 236, 222, 1)),
                      ),
                      // focusNode: passwordInputNode,
                      // autofocus: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 335,
                        height: 66,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        child: GestureDetector(
                          onTap: () => SignUpWithFirebase(context),
                          // Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //         builder: (context) => StudentHomePage())),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text(
                                'SIGN UP',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Color.fromRGBO(247, 236, 222, 1),
                                  fontFamily: 'Reem Kufi Fun',
                                  fontSize: 19,
                                  letterSpacing:
                                      1 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.w400,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ManagerLogin())),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              'Already a user? sign in here',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Reem Kufi Fun',
                                  fontSize: 16,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]))
        // ]
        );
  }
}

// ignore: must_be_immutable
class StudentLogin extends StatelessWidget {
  StudentLogin({super.key});

  FocusNode emailInputNode = FocusNode();
  FocusNode passwordInputNode = FocusNode();

  String? validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  // ignore: unused_element
  String? validatePassword(String value) {
    String pattern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return 'Enter a valid password';
    } else {
      return null;
    }
  }

  TextEditingController emailId = TextEditingController();
  TextEditingController password = TextEditingController();

  void LoginWithFirebase(context) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailId.text, password: password.text)
        .then((value) => {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => StudentHomePage()))
            })
        .catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    void openKeyboard() {
      FocusScope.of(context).requestFocus(emailInputNode);
    }

    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/student_bg.png'),
                fit: BoxFit.fill,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'STUDENT',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Reem Kufi Fun',
                        fontSize: 22,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1),
                  ),
                  Text(
                    'LOGIN',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Reem Kufi Fun',
                        fontSize: 36,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      controller: emailId,
                      validator: (value) => validateEmail(value!),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 231, 212, 158),
                          labelText: "Email ID",
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: new BorderSide(
                                width: 0, color: Color(0xFF4DB6AC)),
                          ),
                          icon: new Icon(Icons.email,
                              size: 50, color: Colors.black)),
                      // focusNode: emailInputNode,
                      // autofocus: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      controller: password,
                      validator: (value) => validatePassword(value!),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF4DB6AC),
                        labelText: "Password",
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                        ),
                        icon:
                            new Icon(Icons.lock, size: 50, color: Colors.black),
                      ),
                      // focusNode: passwordInputNode,
                      // autofocus: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 335,
                        height: 66,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        child: GestureDetector(
                          onTap: () => LoginWithFirebase(context),
                          // Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //         builder: (context) => StudentHomePage())),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text(
                                'LOGIN',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Color.fromRGBO(247, 236, 222, 1),
                                  fontFamily: 'Reem Kufi Fun',
                                  fontSize: 19,
                                  letterSpacing:
                                      1 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.w400,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => StudentSignUpPage())),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              'New user? sign up here',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Reem Kufi Fun',
                                  fontSize: 16,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]))
        // ]
        );
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("L block Mens"), value: "L block Mens"),
    DropdownMenuItem(child: Text("D block Ladies"), value: "D block Ladies"),
    DropdownMenuItem(child: Text("R block Mens"), value: "R block Mens"),
    DropdownMenuItem(child: Text("Q block Mens"), value: "Q block Mens"),
  ];
  return menuItems;
}

// ignore: use_key_in_widget_constructors, must_be_immutable
class StudentSignUpPage extends StatelessWidget {
  FocusNode emailInputNode = FocusNode();
  FocusNode passwordInputNode = FocusNode();

  String? validateName(String value) {
    if (value == null) {
      return 'Please enter your name!';
    } else {
      return null;
    }
  }

  String? validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  // ignore: unused_element
  String? validatePassword(String value) {
    String pattern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return 'Enter a valid password';
    } else {
      return null;
    }
  }

  TextEditingController emailId = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController rePassword = TextEditingController();

  void SignUpWithFirebase(context) {
    if (password.text == rePassword.text) {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailId.text, password: password.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => StudentLogin()));
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    void openKeyboard() {
      FocusScope.of(context).requestFocus(emailInputNode);
    }

    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/student_bg.png'),
                fit: BoxFit.fill,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'STUDENT',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Reem Kufi Fun',
                        fontSize: 22,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1),
                  ),
                  Text(
                    'SIGN UP',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Reem Kufi Fun',
                        fontSize: 36,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      controller: fullName,
                      validator: (value) => validateName(value!),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF4DB6AC),
                          labelText: "Full Name",
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: new BorderSide(
                                width: 0, color: Color(0xFF4DB6AC)),
                          ),
                          icon: new Icon(Icons.person,
                              size: 50, color: Colors.black)),
                      // focusNode: emailInputNode,
                      // autofocus: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      controller: emailId,
                      validator: (value) => validateEmail(value!),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF4DB6AC),
                          labelText: "Email ID",
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: new BorderSide(
                                width: 0, color: Color(0xFF4DB6AC)),
                          ),
                          icon: new Icon(Icons.email,
                              size: 50, color: Colors.black)),
                      // focusNode: emailInputNode,
                      // autofocus: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      controller: password,
                      validator: (value) => validatePassword(value!),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF4DB6AC),
                        labelText: "Password",
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                        ),
                        icon:
                            new Icon(Icons.lock, size: 50, color: Colors.black),
                      ),
                      // focusNode: passwordInputNode,
                      // autofocus: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      controller: rePassword,
                      validator: (value) => validatePassword(value!),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF4DB6AC),
                        labelText: "re-enter Password",
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                        ),
                        icon: new Icon(Icons.lock_open,
                            size: 50, color: Colors.black),
                      ),
                      // focusNode: passwordInputNode,
                      // autofocus: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 335,
                        height: 66,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        child: GestureDetector(
                          onTap: () => SignUpWithFirebase(context),
                          // Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //         builder: (context) => StudentHomePage())),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text(
                                'SIGN UP',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Color.fromRGBO(247, 236, 222, 1),
                                  fontFamily: 'Reem Kufi Fun',
                                  fontSize: 19,
                                  letterSpacing:
                                      1 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.w400,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => StudentLogin())),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              'Already a user? sign in here',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Reem Kufi Fun',
                                  fontSize: 16,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]))
        // ]
        );
  }
}

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/content_bg.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: new GridView.count(
                padding:
                    const EdgeInsets.symmetric(vertical: 140, horizontal: 30),
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFF54BAB9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => LaundryDrop())),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(
                              Icons.local_laundry_service,
                              size: 70,
                            ),
                            Text(
                              'LAUNDRY DROP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: 'Reem Kufi Fun',
                                fontSize: 17,
                                letterSpacing:
                                    1 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                          ],
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFF9ED2C6),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => DropForIron())),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(
                              Icons.iron,
                              size: 60,
                            ),
                            Text(
                              'IRON DROP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: 'Reem Kufi Fun',
                                fontSize: 17,
                                letterSpacing:
                                    1 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                          ],
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFF9ED2C6),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ManagerLogin())),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(
                              Icons.local_laundry_service,
                              size: 60,
                            ),
                            Text(
                              'LAUNDRY COLLECT',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: 'Reem Kufi Fun',
                                fontSize: 17,
                                letterSpacing:
                                    1 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                          ],
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFF54BAB9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ManagerLogin())),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(
                              Icons.iron,
                              size: 60,
                            ),
                            Text(
                              'IRON COLLECT',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: 'Reem Kufi Fun',
                                fontSize: 17,
                                letterSpacing:
                                    1 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                          ],
                        )),
                  ),
                  Column(
                    children: [
                      
                    ],
                  )
                ])));
  }
}

class LaundryDrop extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  LaundryDrop({super.key});

  @override
  _LaundryDropState createState() => _LaundryDropState();
}

class _LaundryDropState extends State<LaundryDrop> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  TextEditingController tokenNo = TextEditingController();

  int _counterShirt = 0;
  int _counterJeans = 0;
  int _counterUGS = 0;
  int _counterTowels = 0;
  int _counterOthers = 0;
  int _totalClothes = 0;

  void _incrementShirt() {
    setState(() {
      _counterShirt++;
      _totalClothes++;
    });
  }

  void _incrementJeans() {
    setState(() {
      _counterJeans++;
      _totalClothes++;
    });
  }

  void _incrementUGS() {
    setState(() {
      _counterUGS++;
      _totalClothes++;
    });
  }

  void _incrementTowels() {
    setState(() {
      _counterTowels++;
      _totalClothes++;
    });
  }

  void _incrementOthers() {
    setState(() {
      _counterOthers++;
      _totalClothes++;
    });
  }

  void _decrementShirt() {
    setState(() {
      _counterShirt--;
      _totalClothes--;
    });
  }

  void _decrementJeans() {
    setState(() {
      _counterJeans--;
      _totalClothes--;
    });
  }

  void _decrementUGS() {
    setState(() {
      _counterUGS--;
      _totalClothes--;
    });
  }

  void _decrementTowels() {
    setState(() {
      _counterTowels--;
      _totalClothes--;
    });
  }

  void _decrementOthers() {
    setState(() {
      _counterOthers--;
      _totalClothes--;
    });
  }

  final CollectionReference _laundry =
      FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/content_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'DROP',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Reem Kufi Fun',
                    fontSize: 30,
                    letterSpacing:
                        1 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
                Text(
                  ' LAUNDRY',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Color(0xFF54BAB9),
                    fontFamily: 'Reem Kufi Fun',
                    fontSize: 30,
                    letterSpacing:
                        1 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'DATE: ',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'Reem Kufi Fun',
                            fontSize: 15,
                            letterSpacing:
                                1 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                        SizedBox(
                          width: 80,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Color(0xFF54BAB9),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Icon(
                              Icons.calendar_today,
                              size: 35,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("${selectedDate.toLocal()}".split(' ')[0]),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                SizedBox(
                  width: 90,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'TOKEN NO: ',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'Reem Kufi Fun',
                            fontSize: 15,
                            letterSpacing:
                                1 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60,
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF9ED2C6)),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: TextFormField(
                        controller: tokenNo,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            decoration: TextDecoration.none,
                            color: Color.fromARGB(255, 178, 178, 178),
                            fontFamily: 'Reem Kufi Fun',
                            fontSize: 15,
                            letterSpacing:
                                1 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text(
                  'CLOTHES COUNT:',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Color(0xFF54BAB9),
                    fontFamily: 'Reem Kufi Fun',
                    fontSize: 25,
                    letterSpacing:
                        1 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
                SizedBox(
                  width: 60,
                ),
                Container(
                    child: Text(
                  "$_totalClothes",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Color(0xFF54BAB9),
                    fontFamily: 'Reem Kufi Fun',
                    fontSize: 25,
                    letterSpacing:
                        1 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("SHIRT / T-SHIRTS: ",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'Reem Kufi Fun',
                      fontSize: 20,
                      letterSpacing:
                          1 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    )),
                Container(
                    child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _decrementShirt();
                      },
                      child: Icon(
                        Icons.remove,
                        size: 35,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "$_counterShirt",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Reem Kufi Fun',
                        fontSize: 20,
                        letterSpacing:
                            1 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _incrementShirt();
                      },
                      child: Icon(
                        Icons.add,
                        size: 35,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Color.fromARGB(255, 124, 124, 124),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("JEANS / TROUSERS: ",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'Reem Kufi Fun',
                      fontSize: 20,
                      letterSpacing:
                          1 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    )),
                Container(
                    child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _decrementJeans();
                      },
                      child: Icon(
                        Icons.remove,
                        size: 35,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "$_counterJeans",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Reem Kufi Fun',
                        fontSize: 20,
                        letterSpacing:
                            1 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _incrementJeans();
                      },
                      child: Icon(
                        Icons.add,
                        size: 35,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Color.fromARGB(255, 124, 124, 124),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("UNDERGARMENTS: ",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'Reem Kufi Fun',
                      fontSize: 20,
                      letterSpacing:
                          1 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    )),
                Container(
                    child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _decrementUGS();
                      },
                      child: Icon(
                        Icons.remove,
                        size: 35,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "$_counterUGS",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Reem Kufi Fun',
                        fontSize: 20,
                        letterSpacing:
                            1 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _incrementUGS();
                      },
                      child: Icon(
                        Icons.add,
                        size: 35,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Color.fromARGB(255, 124, 124, 124),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("TOWELS: ",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'Reem Kufi Fun',
                      fontSize: 20,
                      letterSpacing:
                          1 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    )),
                Container(
                    child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _decrementTowels();
                      },
                      child: Icon(
                        Icons.remove,
                        size: 35,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "$_counterTowels",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Reem Kufi Fun',
                        fontSize: 20,
                        letterSpacing:
                            1 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _incrementTowels();
                      },
                      child: Icon(
                        Icons.add,
                        size: 35,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Color.fromARGB(255, 124, 124, 124),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("OTHERS: ",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'Reem Kufi Fun',
                      fontSize: 20,
                      letterSpacing:
                          1 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    )),
                Container(
                    child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _decrementOthers();
                      },
                      child: Icon(
                        Icons.remove,
                        size: 35,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "$_counterOthers",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Reem Kufi Fun',
                        fontSize: 20,
                        letterSpacing:
                            1 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _incrementOthers();
                      },
                      child: Icon(
                        Icons.add,
                        size: 35,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Color(0xFF54BAB9),
              ),
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Text("DROP",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontFamily: 'Reem Kufi Fun',
                        fontSize: 20,
                        letterSpacing:
                            1 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      )),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () async {
                      await _laundry.add({
                        "clothes": [
                          _counterShirt,
                          _counterJeans,
                          _counterUGS,
                          _counterTowels,
                          _counterOthers
                        ],
                        "date" : selectedDate,
                        "fullName" : "Ayush Gupta",
                        "noOfClothes" : _totalClothes,
                        "pending" : true,
                        "token" : tokenNo.text
                      });
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentHomePage()),
                      );
                    },
                    child: Icon(Icons.arrow_circle_right_rounded,
                        color: Color.fromARGB(255, 255, 255, 255), size: 30),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Drop for iron page

class DropForIron extends StatefulWidget {
  @override
  _DropForIronState createState() => _DropForIronState();
}

class _DropForIronState extends State<DropForIron> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  TextEditingController tokenNo = TextEditingController();

  int _counterShirt = 0;
  int _counterJeans = 0;
  int _counterUGS = 0;
  int _counterTowels = 0;
  int _counterOthers = 0;
  int _totalClothes = 0;

  void _incrementShirt() {
    setState(() {
      _counterShirt++;
      _totalClothes++;
    });
  }

  void _incrementJeans() {
    setState(() {
      _counterJeans++;
      _totalClothes++;
    });
  }

  void _incrementUGS() {
    setState(() {
      _counterUGS++;
      _totalClothes++;
    });
  }

  void _incrementTowels() {
    setState(() {
      _counterTowels++;
      _totalClothes++;
    });
  }

  void _incrementOthers() {
    setState(() {
      _counterOthers++;
      _totalClothes++;
    });
  }

  void _decrementShirt() {
    setState(() {
      _counterShirt--;
      _totalClothes--;
    });
  }

  void _decrementJeans() {
    setState(() {
      _counterJeans--;
      _totalClothes--;
    });
  }

  void _decrementUGS() {
    setState(() {
      _counterUGS--;
      _totalClothes--;
    });
  }

  void _decrementTowels() {
    setState(() {
      _counterTowels--;
      _totalClothes--;
    });
  }

  void _decrementOthers() {
    setState(() {
      _counterOthers--;
      _totalClothes--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/content2_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'DROP FOR',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Reem Kufi Fun',
                    fontSize: 30,
                    letterSpacing:
                        1 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
                Text(
                  ' IRON',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Color.fromARGB(255, 231, 212, 158),
                    fontFamily: 'Reem Kufi Fun',
                    fontSize: 30,
                    letterSpacing:
                        1 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'DATE: ',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'Reem Kufi Fun',
                            fontSize: 15,
                            letterSpacing:
                                1 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                        SizedBox(
                          width: 80,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 231, 212, 158),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Icon(
                              Icons.calendar_today,
                              size: 35,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("${selectedDate.toLocal()}".split(' ')[0]),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                SizedBox(
                  width: 90,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'TOKEN NO: ',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'Reem Kufi Fun',
                            fontSize: 15,
                            letterSpacing:
                                1 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60,
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 231, 212, 158)),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: TextFormField(
                        controller: tokenNo,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            decoration: TextDecoration.none,
                            color: Color.fromARGB(255, 178, 178, 178),
                            fontFamily: 'Reem Kufi Fun',
                            fontSize: 15,
                            letterSpacing:
                                1 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text(
                  'CLOTHES COUNT:',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Color.fromARGB(255, 231, 212, 158),
                    fontFamily: 'Reem Kufi Fun',
                    fontSize: 25,
                    letterSpacing:
                        1 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
                SizedBox(
                  width: 60,
                ),
                Container(
                    child: Text(
                  "$_totalClothes",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Color.fromARGB(255, 231, 212, 158),
                    fontFamily: 'Reem Kufi Fun',
                    fontSize: 25,
                    letterSpacing:
                        1 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("SHIRT / T-SHIRTS: ",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'Reem Kufi Fun',
                      fontSize: 20,
                      letterSpacing:
                          1 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    )),
                Container(
                    child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _decrementShirt();
                      },
                      child: Icon(
                        Icons.remove,
                        size: 35,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "$_counterShirt",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Reem Kufi Fun',
                        fontSize: 20,
                        letterSpacing:
                            1 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _incrementShirt();
                      },
                      child: Icon(
                        Icons.add,
                        size: 35,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Color.fromARGB(255, 124, 124, 124),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("JEANS / TROUSERS: ",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'Reem Kufi Fun',
                      fontSize: 20,
                      letterSpacing:
                          1 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    )),
                Container(
                    child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _decrementJeans();
                      },
                      child: Icon(
                        Icons.remove,
                        size: 35,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "$_counterJeans",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Reem Kufi Fun',
                        fontSize: 20,
                        letterSpacing:
                            1 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _incrementJeans();
                      },
                      child: Icon(
                        Icons.add,
                        size: 35,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Color.fromARGB(255, 124, 124, 124),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("UNDERGARMENTS: ",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'Reem Kufi Fun',
                      fontSize: 20,
                      letterSpacing:
                          1 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    )),
                Container(
                    child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _decrementUGS();
                      },
                      child: Icon(
                        Icons.remove,
                        size: 35,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "$_counterUGS",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Reem Kufi Fun',
                        fontSize: 20,
                        letterSpacing:
                            1 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _incrementUGS();
                      },
                      child: Icon(
                        Icons.add,
                        size: 35,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Color.fromARGB(255, 124, 124, 124),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("TOWELS: ",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'Reem Kufi Fun',
                      fontSize: 20,
                      letterSpacing:
                          1 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    )),
                Container(
                    child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _decrementTowels();
                      },
                      child: Icon(
                        Icons.remove,
                        size: 35,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "$_counterTowels",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Reem Kufi Fun',
                        fontSize: 20,
                        letterSpacing:
                            1 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _incrementTowels();
                      },
                      child: Icon(
                        Icons.add,
                        size: 35,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Color.fromARGB(255, 124, 124, 124),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("OTHERS: ",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'Reem Kufi Fun',
                      fontSize: 20,
                      letterSpacing:
                          1 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    )),
                Container(
                    child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _decrementOthers();
                      },
                      child: Icon(
                        Icons.remove,
                        size: 35,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "$_counterOthers",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Reem Kufi Fun',
                        fontSize: 20,
                        letterSpacing:
                            1 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _incrementOthers();
                      },
                      child: Icon(
                        Icons.add,
                        size: 35,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Color.fromARGB(255, 231, 212, 158),
              ),
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Text("DROP",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Reem Kufi Fun',
                        fontSize: 20,
                        letterSpacing:
                            1 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      )),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentHomePage()),
                      );
                    },
                    child: Icon(Icons.arrow_circle_right_rounded,
                        color: Color.fromARGB(255, 0, 0, 0), size: 30),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PendingLaundry extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  PendingLaundry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Container(
        child: Column(children: [
          Container(
              width: 369,
              height: 132,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Color.fromRGBO(247, 236, 223, 1),
                border: Border.all(
                  color: Color.fromRGBO(84, 186, 185, 1),
                  width: 1,
                ),
              ))
        ]),
      ),
    );
  }
}
