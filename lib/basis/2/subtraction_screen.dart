import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdp_project/basis/2/special_type_money.dart';

class SubtractionScreen extends StatefulWidget {
  const SubtractionScreen({Key? key}) : super(key: key);

  @override
  _SubtractionScreenState createState() => _SubtractionScreenState();
}

class _SubtractionScreenState extends State<SubtractionScreen> {
  String message = '';
  final formKey = GlobalKey<FormState>();
  late MyMoney myMoney1;
  late MyMoney myMoney2;
  final TextEditingController inputStringController1 = TextEditingController();
  final TextEditingController inputStringController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text(
            '${myMoney1 = MyMoney(inputString: inputStringController1.text)} - ${myMoney2 = MyMoney(inputString: inputStringController2.text)}'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Center(
                  child: Container(
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          setState(
                            () {
                              myMoney1 = MyMoney(
                                  inputString: inputStringController1.text);
                            },
                          );
                        },
                        controller: inputStringController1,
                        decoration: InputDecoration(
                          hintText: 'Enter the first value',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                        ],
                        validator: showValidate),
                  ),
                ),
                Center(
                  child: Container(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        setState(
                          () {
                            myMoney2 = MyMoney(
                                inputString: inputStringController2.text);
                          },
                        );
                      },
                      controller: inputStringController2,
                      decoration: InputDecoration(
                        hintText: 'Enter the second value',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                      ],
                      validator: showValidate,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 28, bottom: 48),
                  child: Text(
                    message,
                    style: TextStyle(color: Colors.pink, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () => validator(),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'RESULT',
                      style: const TextStyle(fontSize: 14),
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

  String? showValidate(value) {
    if (value!.isEmpty) {
      setState(
        () {
          message = 'It is foolish to check an empty field';
        },
      );
      return '';
    }
    return null;
  }

  void validator() async {
    if (formKey.currentState!.validate()) {
      setState(
        () {
          message = MyMoney(
                  inputString: MyMoney(inputString: '')
                      .subtractionMoneyObjects(myMoney1, myMoney2))
              .toString();
        },
      );
    }
  }
}
