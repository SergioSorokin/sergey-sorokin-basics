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
                  onChanged: (value) {
                    setState(
                      () {
                        inputNumber = numberController.text;
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
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]'),
                    )
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
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(minWidth: double.maxFinite, minHeight: 48),
          child: ElevatedButton(
            onPressed: validator,
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
    );
  }

  void validator() {
    if (formKey.currentState!.validate()) {
      for (var count = inputNumber.length; count > 0; count--) {
        parseNumber = int.parse(inputNumber);
      }
      setState(
        () {
          factorial = '';
          if (parseNumber == 0) {
            factorial = '1';
          }
          factorialCalculation();
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    numberController.dispose();
  }

  factorialCalculation() {
    while (countFC <= parseNumber) {
      store = (store * countFC);
      factorial = store.toString();
      countFC++;
      print(factorial);
      print(parseNumber);
    }
    // print(factorial);
    store = 1;
    countFC = 1;
  }
}
