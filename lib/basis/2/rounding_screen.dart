import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdp_project/basis/2/special_type_money.dart';

class RoundingScreen extends StatefulWidget {
  const RoundingScreen({Key? key}) : super(key: key);

  @override
  _RoundingScreenState createState() => _RoundingScreenState();
}

class _RoundingScreenState extends State<RoundingScreen> {
  String inputString = '';
  int rounding = 1;
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
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text('RoundingScreen'),
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
                  padding: const EdgeInsets.only(top: 50, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 3,
                        groupValue: selectValue,
                        onChanged: (value) {
                          onChanged(value);
                          rounding = 1000;
                        },
                      ),
                      Radio(
                        value: 2,
                        groupValue: selectValue,
                        onChanged: (value) {
                          onChanged(value);
                          rounding = 100;
                        },
                      ),
                      Radio(
                        value: 1,
                        groupValue: selectValue,
                        onChanged: (value) {
                          onChanged(value);
                          rounding = 10;
                        },
                      ),
                      Radio(
                        value: 0,
                        groupValue: selectValue,
                        onChanged: (value) {
                          onChanged(value);
                          rounding = 1;
                        },
                      ),
                    ],
                  ),
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
          message = MyMoney.roundingMethod(_myMoney, rounding).toString();
        },
      );
    }
  }
}
