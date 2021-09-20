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
  String number = '';
  String symbol = '! :';
  String factorial = '';
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
            Padding(
              padding: const EdgeInsets.only(left: 192, right: 192),
              child: TextFormField(
                textAlign: TextAlign.center,
                maxLength: 4,
                onChanged: (value) {
                  setState(
                    () {
                      number = numberController.text;
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
                    return 'Пожалуйста, введите число!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 8),
              child: Text(
                  'Факториал числа $number${number == '' ? number : symbol}'),
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
              'Узнать факториал числа $number',
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }

  void validator() {
    if (formKey.currentState!.validate()) {
      setState(
        () {
          factorial = '';
          if (number == '0') {
            factorial = '1';
          }
        },
      );
      print(number);
    }
  }

  @override
  void dispose() {
    super.dispose();
    numberController.dispose();
  }
}
