// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ManagerLogin())),
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

class ManagerLogin extends StatelessWidget {
  const ManagerLogin({super.key});

  @override
  Widget build(BuildContext context) {
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
                'LAUNDRY/IRON MANAGER',
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
              )
            ]),
      ),
    );
  }
}

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
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(84, 186, 185, 1),
      ),
    );
  }
}



// class Drawhorizontalline extends CustomPainter {
//   Paint _paint;
//   Drawhorizontalline() {
//     _paint = Paint()
//     ..color = Colors.white
//     ..strokeWidth = 1
//     ..strokeCap = StrokeCap.round;
//   }
// @override
// void paint(Canvas canvas, Size size) {
// canvas.drawLine(Offset(-90.0, 0.0), Offset(90.0, 0.0), _paint);
// }
// @override
// bool shouldRepaint(CustomPainter oldDelegate) {
// return false;
// }
// }