import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdp_project/basis/2/money_type/special_type_money.dart';

class CalculationScreen extends StatefulWidget {
  final TextEditingController inputStringController1;
  const CalculationScreen(this.inputStringController1, {Key? key})
      : super(key: key);

  @override
  _CalculationScreenState createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  late String message = '';
  final formKey = GlobalKey<FormState>();
  late MyMoney myMoney1;
  late MyMoney myMoney2;
  late String inputFactor;
  late FocusNode _focusNode = FocusNode();
  late final TextEditingController inputStringController1 =
      widget.inputStringController1;
  final TextEditingController inputStringController2 = TextEditingController();

  void initialState() {
    inputStringController2.clear();
    _focusNode.requestFocus();
    message = '';
  }

  @override
  Widget build(BuildContext context) {
    if (inputStringController1.text.isEmpty) {
      initialState();
    }
    return Scaffold(
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
                        focusNode: _focusNode,
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
                          FilteringTextInputFormatter.allow(RegExp('[0-9.-]')),
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
                            inputFactor = inputStringController2.text;
                            myMoney2 = MyMoney(inputString: inputFactor);
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
                        FilteringTextInputFormatter.allow(RegExp('[0-9.-]')),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: ElevatedButton(
                        onPressed: () => validator(1),
                        child: Icon(Icons.add_rounded),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: ElevatedButton(
                        onPressed: () => validator(2),
                        child: Icon(Icons.remove_rounded),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: ElevatedButton(
                        onPressed: () => validator(3),
                        child: Text('VS'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: ElevatedButton(
                        onPressed: () => validator(4),
                        child: Text(
                          'X',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: ElevatedButton(
                        onPressed: () => validator(5),
                        child: Text(
                          '/',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
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

  void validator(int _identification) async {
    if (formKey.currentState!.validate()) {
      switch (_identification) {
        case 1:
          setState(
            () {
              message =
                  MyMoney.additionMoneyObjects(myMoney1, myMoney2).toString();
            },
          );
          break;
        case 2:
          setState(
            () {
              message = MyMoney.subtractionMoneyObjects(myMoney1, myMoney2)
                  .toString();
            },
          );
          break;
        case 3:
          setState(
            () {
              var tempSymbol = MyMoney(
                      inputString:
                          MyMoney.comparisonMoneyObjects(myMoney1, myMoney2))
                  .toString();
              message = '$myMoney1 $tempSymbol $myMoney2';
            },
          );
          break;
        case 4:
          setState(
            () {
              message = (MyMoney.multiplicationMethod(myMoney1, inputFactor))
                  .toString();
            },
          );
          break;
        case 5:
          setState(
            () {
              message =
                  (MyMoney.divisionMethod(myMoney1, inputFactor)).toString();
            },
          );
          break;
      }
    }
  }
}
