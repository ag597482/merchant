import 'package:flutter/material.dart';
import 'package:merchant/helpers/shared_preference_service.dart';
import 'package:merchant/home.dart';
import 'package:merchant/login.dart';
import 'package:merchant/register.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferenceService prefService = SharedPreferenceService();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // initialRoute: 'login',
    home: FutureBuilder<bool>(
      future: prefService.getLoginStatus(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == false) {
          return const MyLogin();
        } else {
          return const MyHome();
        }
      },
    ),
    routes: {
      'login': (context) => const  MyLogin(),
      'register': (context) => const MyRegester(),
      'home': (context) =>const MyHome()
    },
  ));
}
