import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FourDigitPalindrome extends StatefulWidget {
  static const String routName = '/palindrome';
  const FourDigitPalindrome({Key? key}) : super(key: key);

  @override
  State<FourDigitPalindrome> createState() => _FourDigitPalindromeState();
}

class _FourDigitPalindromeState extends State<FourDigitPalindrome> {
  String inputNumber = '';
  String message = '';
  final formKey = GlobalKey<FormState>();
  final TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text('Palindrome?'),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 8),
                  child: Text('Enter the number'),
                ),
                Center(
                  child: Container(
                    width: 80,
                    height: 60,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      maxLength: 8,
                      onFieldSubmitted: validator,
                      onChanged: (value) {
                        setState(
                          () {
                            inputNumber = numberController.text;
                            // int.parse(numberController.text).toString();
                          },
                        );
                      },
                      controller: numberController,
                      decoration: InputDecoration(
                        hintText: '',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(
                            () {
                              message = 'It is foolish to check an empty field';
                            },
                          );
                          return '';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 8),
                  child: Text(''),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 28, bottom: 8),
                  child: Text(
                    message,
                    style: TextStyle(color: Colors.pink, fontSize: 32),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                        minWidth: double.maxFinite, minHeight: 48),
                    child: ElevatedButton(
                      onPressed: () => validator(inputNumber),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Find out',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validator(String inputNumber) {
    if (formKey.currentState!.validate()) {
      setState(
        () {
          message = checkPalindrome(inputNumber);
        },
      );
    }
  }

  String checkPalindrome(String inputNumber) {
    int index = 0;
    int indexRev = inputNumber.length - 1;
    while (indexRev > index) {
      if (inputNumber[indexRev] == inputNumber[index]) {
        index++;
        indexRev--;
      } else {
        message = 'NO';
        break;
      }
      message = 'YES';
    }

    return message;
  }
}
