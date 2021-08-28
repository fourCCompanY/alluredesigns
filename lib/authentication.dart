import 'package:allurenew/OTP_Page.dart';
import 'package:allurenew/haveanaccount.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
//=================MY OWN IMPORTS=====================
import 'package:allurenew/fireflutter.dart';

String phoneNumber;

class Authentication extends StatefulWidget {
  Authentication({Key key}) : super(key: key);
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
  }

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _repasswordController = TextEditingController();
  bool view = false;
  bool checkedValue = true;
  bool textView = true;
  autoFill() async {
    _phoneController.text = await SmsAutoFill().hint;
  }

  // ignore: missing_return
  Future<bool> phone() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OTPScreen(
          mobileNumber: '$phoneNumber',
        ),
      ),
    );
    return registeruser(
        _emailcontroller.text.trim(), _passwordcontroller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image(
              image: AssetImage(
                'images/signin.jpg',
              ),
              fit: BoxFit.cover,
              color: Colors.black45,
              colorBlendMode: BlendMode.darken,
            ),
            Positioned(
              top: size.height * .01,
              left: size.width * .37,
              child: Text(
                'SIGN UP',
                style: TextStyle(
                    color: Colors.white60,
                    letterSpacing: 3.0,
                    fontSize: 25.00,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway'),
              ),
            ),
            Positioned(
              top: size.height * .3,
              left: size.width * .05,
              width: size.width * .8,
              child: TextField(
                controller: _emailcontroller,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Enter Your Email',
                  labelStyle: TextStyle(
                    color: Colors.white70,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white60)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white60)),
                ),
              ),
            ),
            Positioned(
              top: size.height * .4,
              left: size.width * .15,
              width: size.width * .8,
              child: TextField(
                obscureText: checkedValue,
                controller: _passwordcontroller,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Enter Your Password',
                  labelStyle: TextStyle(
                    color: Colors.white70,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white60)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white60)),
                ),
              ),
            ),
            Positioned(
              top: size.height * .5,
              left: size.width * .05,
              width: size.width * .8,
              child: TextField(
                onChanged: (value) {
                  if (value != _passwordcontroller.toString()) {
                    SnackBar(
                      content: Text("Password's Dosent Match"),
                    );
                  }
                },
                obscureText: checkedValue,
                controller: _repasswordController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'ReType Your Password',
                  labelStyle: TextStyle(
                    color: Colors.white70,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white60)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white60)),
                ),
              ),
            ),
            Positioned(
              top: size.height * .5,
              left: size.width * .85,
              child: Checkbox(
                  autofocus: true,
                  value: checkedValue,
                  onChanged: (bool value) {
                    setState(() {
                      checkedValue = value;
                    });
                  }),
            ),
            Positioned(
              top: size.height * .6,
              left: size.width * .15,
              width: size.width * .8,
              child: TextField(
                onChanged: (value) {
                  if (value.length == 10) {
                    setState(() {
                      view = true;
                      phoneNumber = value;
                      textView = false;
                    });
                  }
                  if (value.length < 10) {
                    setState(() {
                      view = false;
                      textView = true;
                    });
                  }
                  if (value.length > 10) {
                    setState(() {
                      view = false;
                    });
                  }
                },
                obscureText: false,
                controller: _phoneController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter your number without Country code',
                  hintStyle: TextStyle(
                    color: Colors.white70,
                  ),
                  labelText: 'Enter Your Phone Number',
                  labelStyle: TextStyle(
                    color: Colors.white70,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white60)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white60)),
                ),
              ),
            ),
            Positioned(
              top: size.height * .7,
              left: size.width * .27,
              child: Visibility(
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: view,
                child: MaterialButton(
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  height: 40.00,
                  minWidth: 200.00,
                  splashColor: Colors.teal,
                  color: Colors.transparent,
                  colorBrightness: Brightness.dark,
                  onPressed: () async {
                    await phone();
                    registeruser(
                        _emailcontroller.toString().trim().toLowerCase(),
                        _passwordcontroller.toString().trim());
                    // bool shouldNavigate = await phone();
                    // if (shouldNavigate == true) {
                    //   return null;
                    // } else {
                    //   showDialog(
                    //       context: context,
                    //       builder: (context) {
                    //         return AlertDialog(
                    //           title: Text(
                    //               'Account creation has been unsuccesful try to Log In',
                    //               style: TextStyle(color: Colors.red)),
                    //         );
                    //       });
                    // }
                  },
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                        fontSize: 18.00,
                        letterSpacing: 1.00),
                  ),
                ),
              ),
            ),
            Positioned(
              top: size.height * .7,
              left: size.width * .27,
              child: Visibility(
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: textView,
                child: Text(
                  'Enter All Information For Creating Account*',
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              top: size.height * .8,
              left: size.width * .32,
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Logsign()));
                },
                child: Text(
                  'Have an account? Log In',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Textfield extends StatelessWidget {
  Textfield({
    @required this.controller,
    // ignore: non_constant_identifier_names
    @required this.label_text,
    @required this.hintText,
    // ignore: non_constant_identifier_names
    @required this.obscure_text,
  });
  // ignore: non_constant_identifier_names
  final bool obscure_text;
  final String hintText;
  // ignore: non_constant_identifier_names
  final String label_text;
  final controller;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 40.00,
      padding: EdgeInsets.only(
        left: size.width * .05,
        right: size.width * .05,
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure_text,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.white, fontSize: 15.00),
          hintText: hintText,
          labelText: label_text,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 15.00),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  Button({
    @required this.press,
    @required this.text,
    @required this.color,
    @required this.textColor,
    this.splashcolor,
  });
  final Function press;
  final String text;
  final Color color;
  final Color textColor;
  final Color splashcolor;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.00)),
      splashColor: splashcolor,
      onPressed: press,
      color: color,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: textColor,
          fontSize: 17.00,
        ),
      ),
    );
  }
}

// class OtpScreen extends StatefulWidget {
//   @override
//   _OtpScreenState createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {

//   @override
//   void initState() {
//     super.initState();
//   }
//   TextEditingController _phoneController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       resizeToAvoidBottomPadding: true,
//       backgroundColor: kOurThemeColor,
//       body: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.fromLTRB(0, 60, 30, 60),
//             decoration: BoxDecoration(),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Phone Number',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 50.00,
//                       letterSpacing: 3.0),
//                 ),
//                 SizedBox(
//                   height: 20.00,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20.0),
//                   child: Text(
//                     'Account Creation',
//                     style: TextStyle(
//                       letterSpacing: 5,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15.00,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(50.00),
//                   topLeft: Radius.circular(50.00),
//                 ),
//               ),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(60.0),
//                       child: TextField(
//                         controller: _phoneController,
//                         onChanged: (value) {
//                           if (value.length == 10) {
//                             setState(() {
//                               view = true;
//                               phoneNumber = value;
//                             });
//                           }
//                           if (value.length < 10) {
//                             setState(() {
//                               view = false;
//                             });
//                           }
//                         },
//                         style: TextStyle(fontSize: 18.0),
//                         maxLength: 10,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           labelText: 'Enter Your Mobile Number',
//                           labelStyle: TextStyle(color: Colors.black),
//                           hintText: '\t\t\t\tEnter Your Mobile Number',
//                           hintStyle: TextStyle(
//                             color: Colors.grey[400],
//                           ),
//                           focusColor: kOurThemeColor,
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: kOurThemeColor,
//                             ),
//                           ),
//                           prefix: Padding(
//                             padding: EdgeInsets.all(4),
//                             child: Text(
//                               '+91',
//                               style: TextStyle(color: Colors.black87),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Expanded(child: OtpInput())
//         ],
//       ),
//     );
//   }
// }

// class OtpInput extends StatefulWidget {
//   @override
//   _OtpInputState createState() => _OtpInputState();
// }

// class _OtpInputState extends State<OtpInput> {
//   @override
//   void initState() {
//     super.initState();
//     Firebase.initializeApp();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Container(
//           color: Colors.white,
//           height: size.height * .3,
//           child: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(20.00),
//                   ),
//                   child: Visibility(
//                     maintainSize: true,
//                     maintainAnimation: true,
//                     maintainState: true,
//                     visible: view,
//                     child: MaterialButton(
//                       padding: EdgeInsets.all(20),
//                       splashColor: Colors.white,
//                       color: kOurThemeColor,
//                       child: Text('Get OTP',
//                           style: TextStyle(color: Colors.white)),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => OTPScreen(
//                               mobileNumber: '$phoneNumber',
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }
