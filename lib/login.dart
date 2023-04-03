import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:merchant/helpers/constants.dart';

import 'helpers/api_service.dart';
import 'helpers/shared_preference_service.dart';
import 'models/user.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

void showD(context, text) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        // Retrieve the text that the user has entered by using the
        // TextEditingController.
        content: Text(text),
      );
    },
  );
}

void showToast(text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.shade700,
      textColor: Colors.white,
      fontSize: 12.0);
}

class _MyLoginState extends State<MyLogin> {
  late List<User>? _userModel = [];
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final SharedPreferenceService prefService = SharedPreferenceService();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _userModel = (await ApiService().getUsers())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text("Welcome\nBack",
                  style: TextStyle(color: Colors.white, fontSize: 33)),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.45,
                    right: 35,
                    left: 35),
                child: Column(children: [
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Phone No.',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sign In",
                        style: TextStyle(
                            color: Color(0xff4c505b),
                            fontSize: 27,
                            fontWeight: FontWeight.w700),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xff4c505b),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            if (phoneController.text.length == 0 ||
                                passwordController.text.length == 0) {
                              showToast(Constants.emptyPhoneOrPassword);
                            } else {
                              var userFound = 0;
                              for (User u in _userModel!) {
                                // TODO: update id to phone number
                                if (u.id.toString() ==
                                    phoneController.text.toString()) {
                                  userFound = 1;
                                  print(u.address.geo.lat.toString());
                                  if (u.address.geo.lat.toString() ==
                                      passwordController.text.toString()) {
                                    prefService.updateLoginStatus(true);
                                    showToast(Constants.welcome);
                                    Navigator.pushNamed(context, 'home');
                                  } else {
                                    showToast(Constants.incorrectPasswordToast);
                                  }
                                }
                              }
                              if (userFound == 0) {
                                showToast(Constants.userNotFound);
                              }
                            }
                            //Navigator.pushNamed(context, 'home');
                          },
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'register');
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Color(0xff4c505b)),
                          )),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forget Password",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Color(0xff4c505b)),
                          ))
                    ],
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
