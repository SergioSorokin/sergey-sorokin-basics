import 'package:flutter/material.dart';
import 'package:pdp_project/basis/2/special_type_money.dart';

class MoneyScreen extends StatefulWidget {
  static const String routName = '/moneyScreen';
  const MoneyScreen({Key? key}) : super(key: key);

  @override
  _MoneyScreenState createState() => _MoneyScreenState();
}

class _MoneyScreenState extends State<MoneyScreen> {
  String inputString = '';
  String message = '';
  final formKey = GlobalKey<FormState>();
  final TextEditingController inputStringController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text('MoneyScreen'),
        centerTitle: true,
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
                  child: Text('Enter the value'),
                ),
                Center(
                  child: Container(
                    // width: 80,
                    // height: 60,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      // maxLength: 8,
                      onFieldSubmitted: validator,
                      onChanged: (value) {
                        setState(
                          () {
                            inputString = inputStringController.text;
                            // int.parse(numberController.text).toString();
                          },
                        );
                      },
                      controller: inputStringController,
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
                        // FilteringTextInputFormatter.digitsOnly,
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
                      onPressed: () => validator(inputString),
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

  void validator(String inputString) async {
    if (formKey.currentState!.validate()) {
      var result = MyMoney(inputString: inputString);
      setState(
        () {
          message = result.toString();
        },
      );
    }
  }
}
