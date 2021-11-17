import 'package:flutter/material.dart';
import 'package:pdp_project/basis/1/18_factorial.dart';
import 'package:pdp_project/basis/1/324_four_digit_palindrome.dart';
import 'package:pdp_project/basis/2/money_type/screens/money_type_screen.dart';
import 'package:pdp_project/basis/3/number_systems.dart';
import 'package:pdp_project/basis/3/time_conversion.dart';

class HomePage {
  static const String routName = '/homePage';

  static initRoute(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'PDP Project',
            style: TextStyle(fontSize: 44),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Factorial.routName,
                      );
                    },
                    child: Text(
                      'Factorial',
                      style: TextStyle(fontSize: 32),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        FourDigitPalindrome.routName,
                      );
                    },
                    child: Text(
                      'Palindrome',
                      style: TextStyle(fontSize: 32),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        NumberSystems.routName,
                      );
                    },
                    child: Text(
                      'NumConverter',
                      style: TextStyle(fontSize: 32),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        TimeConversion.routName,
                      );
                    },
                    child: Text(
                      'TimeConversion',
                      style: TextStyle(fontSize: 32),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        MoneyTypeScreen.routName,
                      );
                    },
                    child: Text(
                      'MoneyTypeScreen',
                      style: TextStyle(fontSize: 32),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
