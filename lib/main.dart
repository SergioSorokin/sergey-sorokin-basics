import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdp_project/basis/1/18_factorial.dart';
import 'package:pdp_project/basis/1/324_four_digit_palindrome.dart';
import 'package:pdp_project/home_page.dart';

main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomePage.routName: (context) => HomePage.initRoute(context),
        Factorial.routName: (context) => Factorial(),
        FourDigitPalindrome.routName: (context) => FourDigitPalindrome()
      },
      initialRoute: HomePage.routName,
    );
  }
}
