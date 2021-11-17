import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdp_project/basis/2/money_type/special_type_money.dart';

class RoundingScreen extends StatefulWidget {
  const RoundingScreen({Key? key}) : super(key: key);

  @override
  _RoundingScreenState createState() => _RoundingScreenState();
}

class _RoundingScreenState extends State<RoundingScreen> {
  String inputString = '';
  bool _isoOverflow = false;
  int _rounding = 1;
  String message = '';
  var selectValue = 0;
  late MyMoney _myMoney;
  final formKey = GlobalKey<FormState>();
  final TextEditingController inputStringController = TextEditingController();

  onChanged(value) {
    setState(() => selectValue = value);
  }

  @override
  Widget build(BuildContext context) {
    String messageOverflow = _isoOverflow.toString();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text('Rounding Screen'),
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
                  padding: const EdgeInsets.only(top: 32, bottom: 8),
                  child: Text('Enter the value'),
                ),
                Center(
                  child: Container(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        setState(
                          () {
                            _myMoney = MyMoney(
                                inputString: inputStringController.text);
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
                        FilteringTextInputFormatter.allow(RegExp('[0-9.-]')),
                      ],
                      validator: showValidate,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Column(
                    children: [
                      Text('OVERFLOW'),
                      Switch(
                        value: _isoOverflow,
                        onChanged: (value) {
                          this.setState(() => _isoOverflow = value);
                          messageOverflow = _isoOverflow.toString();
                        },
                      ),
                      Text(
                        messageOverflow,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            child: Radio(
                              value: 3,
                              groupValue: selectValue,
                              onChanged: (value) {
                                onChanged(value);
                                _rounding = 1000;
                              },
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                                text: '0',
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '0',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  TextSpan(
                                    text: '.',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: '00',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        child: Column(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: selectValue,
                              onChanged: (value) {
                                onChanged(value);
                                _rounding = 100;
                              },
                            ),
                            RichText(
                              text: TextSpan(
                                  text: '00.',
                                  style: TextStyle(color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '00',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 12),
                        child: Column(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: selectValue,
                              onChanged: (value) {
                                onChanged(value);
                                _rounding = 10;
                              },
                            ),
                            RichText(
                              text: TextSpan(
                                  text: '00.0',
                                  style: TextStyle(color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '0',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        child: Column(
                          children: [
                            Radio(
                              value: 0,
                              groupValue: selectValue,
                              onChanged: (value) {
                                onChanged(value);
                                _rounding = 1;
                              },
                            ),
                            Text(
                              '00.00',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                  child: ElevatedButton(
                    onPressed: () => validator(),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Show in monetary terms',
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
          message = MyMoney.roundingMethod(_myMoney, _rounding, _isoOverflow)
              .toString();
        },
      );
    }
  }
}
