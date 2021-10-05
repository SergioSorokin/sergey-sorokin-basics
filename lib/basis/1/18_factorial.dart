import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String inputNumber = '';
  String symbol = '! :';
  String factorial = '';
  int parseNumber = 1;
  int countFC = 1;
  int store = 1;
  int temp = 0;
  final formKey = GlobalKey<FormState>();
  final TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text('Факториал числа'),
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
                  child: Text('Введите число '),
                ),
                Center(
                  child: Container(
                    width: 80,
                    height: 60,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      maxLength: 3,
                      onFieldSubmitted: validator,
                      onChanged: (value) {
                        setState(
                          () {
                            inputNumber =
                                int.parse(numberController.text).toString();
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
                              factorial = 'Глупо проверять пустое поле';
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
                  child: Text(
                      'Факториал числа $inputNumber${inputNumber == '' ? inputNumber : symbol}'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 28, bottom: 8),
                  child: Text(
                    factorial,
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
                        'Узнать факториал числа $inputNumber',
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
      for (var count = inputNumber.length; count > 0; count--) {
        parseNumber = int.parse(inputNumber);
      }
      setState(
        () {
          factorial = factorialCalculation(inputNumber);
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    numberController.dispose();
  }

  String factorialCalculation(String inputNumber) {
    String factorStr = '';
    String resultFactorStr = '';
    String factorial = '';
    int parseNumber = 0;

    int factor = 0;
    int factor1 = 0;
    int temp = 0;
    int parse = 0;

    parseNumber = int.parse(inputNumber);
    factor = parseNumber - 1;

    while (factor > 1) {
      for (var count = inputNumber.length; count >= 0; count--) {
        if (count > 0) {
          parse = int.parse(inputNumber[count - 1]);
          factor1 = (factor * parse) + temp;
          factorStr = (factor1 % 10).toString();
          resultFactorStr = factorStr + resultFactorStr;
          temp = factor1 % 1000 ~/ 10;
        } else {
          if (temp != 0) {
            resultFactorStr = temp.toString() + resultFactorStr;
          }

          temp = 0;
        }
      }
      if (resultFactorStr[0] == '0' && resultFactorStr.length > 1) {
        inputNumber = resultFactorStr.substring(1);
      }
      inputNumber = resultFactorStr;
      resultFactorStr = '';
      factor--;
    }
    if (inputNumber == '0') {
      factorial = '1';
    } else {
      factorial = inputNumber;
    }
    return factorial;
  }
}
