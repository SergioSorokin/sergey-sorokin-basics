import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberSystems extends StatefulWidget {
  static const String routName = '/numberSystems';
  const NumberSystems({Key? key}) : super(key: key);

  @override
  _NumberSystemsState createState() => _NumberSystemsState();
}

class _NumberSystemsState extends State<NumberSystems> {
  String inputNumber = '';
  String message = '';
  final formKey = GlobalKey<FormState>();
  final TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text('NumConverter'),
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
                    style: TextStyle(color: Colors.pink, fontSize: 18),
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
                        'To know',
                        style: const TextStyle(fontSize: 14),
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
          message = numberConverter(inputNumber);
        },
      );
    }
  }

  String numberConverter(String inputNumber) {
    int parseNumber;
    String result = '';
    if (inputNumber != '0') {
      parseNumber = int.parse(inputNumber);
      while ((parseNumber / 2) != 0) {
        result = ((parseNumber % 2).toString()) + result;
        parseNumber = parseNumber ~/ 2;
      }
      message = result;
    } else {
      message = inputNumber;
    }

    // message = parseNumber.toRadixString(2);
    return message;
  }
}
