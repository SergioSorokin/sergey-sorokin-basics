class MyMoney {
  late final int dollars;
  late final int cents;
  late final int _sign;

  List<String> _listInputString = ['', ''];
  bool _isNegative = false;
  bool _isSymbol = false;

  MyMoney({required String inputString}) {
    _parseInputString(inputString);
  }
  void _parseInputString(String _inputString) {
    int _tempNumber;
    int _tempDollars;
    int _tempCents;
    if (_inputString.contains('<') ||
        _inputString.contains('=') ||
        _inputString.contains('>')) {
      _isSymbol = true;
      _listInputString[0] = _inputString;
      dollars = 0;
      cents = 0;
    } else {
      _listInputString = _checkingCurrentInput(_inputString);
      _tempDollars = int.parse(_listInputString[0]);
      _tempCents = _listInputString[1].length == 1
          ? int.parse(_listInputString[1]) * 10
          : int.parse(_listInputString[1]);
      _tempNumber = _concatenationOfNumbers(_tempDollars, _tempCents);
      // print('_tempNumber $_tempNumber');
      // print('_tempDollars $_tempDollars');
      // print('_tempCents $_tempCents');
      _listInputString = _splittingNumbers(_tempNumber);
      print('_listInputString $_listInputString');
      dollars = int.parse(_listInputString[0]);
      cents = int.parse(_listInputString[1]);
      print('dollars $dollars');
      print('cents $cents');
    }
  }

  List<String> _checkingCurrentInput(String _inputString) {
    List<String> _result = ['', ''];
    _result = _inputString.split('.');
    if (_inputString.contains('.')) {
      _result = _inputString.split('.');
    } else {
      _result = ['$_inputString', '0'];
    }
    _result[0].contains('-') ? _sign = -1 : _sign = 1;
    _result[0] =
        _result[0] == '-' && _result[0].length == 1 || _result[0].isEmpty
            ? '0'
            : _result[0];
    _result[1] = _result[1].isEmpty ? '0' : _result[1];
    return _result;
  }

  int _concatenationOfNumbers(int _dollars, int _cents) {
    int _result;
    _result = _cents.toString().length > 2
        ? _sign * ((_sign * (_dollars * 100)) + (_overflow(_listInputString)))
        : _sign * ((_sign * (_dollars * 100)) + _cents);
    print('_concatenationOfNumbers  $_result');
    return _result;
  }

  int _overflow(List<String> _inputList) {
    var _result;
    var _temp;
    _temp = int.parse(_inputList[1].substring(2, 3));
    if (_temp >= 5) {
      _result = int.parse(_inputList[1].substring(0, 2)) + 1;
    } else {
      _result = int.parse(_inputList[1].substring(0, 2));
    }
    // print('_overflow $_result');
    return _result;
  }

  List<String> _splittingNumbers(int _tempNumbers) {
    List<String> _result = ['', ''];
    _tempNumbers = _tempNumbers * _sign;
    String _tempDollars;
    String _tempCents;
    _tempDollars = ((_tempNumbers ~/ 100) * _sign).toString();
    _tempCents = (_tempNumbers % 100).toString();
    _tempCents = _tempCents.length == 1 ? '0' + _tempCents : _tempCents;
    // print('_splittingNumbers $_tempNumbers');
    // print('_tempDollars $_tempDollars');
    // print('_tempCents $_tempCents');
    _result = [
      _sign == -1 && _tempDollars == '0' ? '-0' : _tempDollars,
      _tempCents
    ];
    return _result;
  }

  @override
  String toString() {
    var _result;
    _result = !_isSymbol
        ? '${_listInputString[0]}\$ ${_listInputString[1]}¢'
        : _listInputString[0];
    return _result;
  }

  // void _parseInputString(String inputString) {
  //   if (inputString.contains('<') ||
  //       inputString.contains('=') ||
  //       inputString.contains('>')) {
  //     _listInputString[0] = inputString;
  //     _listInputString[1] = 'isSymbol';
  //     dollars = 0;
  //     cents = 0;
  //   } else {
  //     if (inputString.contains('-') && inputString.length < 2 ||
  //         inputString.contains('-.') && inputString.length < 3) {
  //     } else if (inputString.contains('.')) {
  //       _listInputString = inputString.split('.');
  //       if (_listInputString[0] == '-' && _listInputString[0].length == 1) {
  //         _listInputString[0] = '-0';
  //       }
  //     } else {
  //       _listInputString[0] = inputString;
  //       _listInputString[1] = '0';
  //     }
  //     var hasOverflow = false;
  //     if (_listInputString.length > 0 && _listInputString[1].isNotEmpty) {
  //       if (_listInputString[1].length == 1) {
  //         cents = int.parse(_listInputString[1]) * 10;
  //       } else if (_listInputString[1].length > 2) {
  //         cents = _overflow(_listInputString);
  //         if (cents == 0) {
  //           hasOverflow = true;
  //         }
  //       } else {
  //         cents = int.parse(_listInputString[1]);
  //       }
  //     } else {
  //       cents = 0;
  //     }
  //     if (_listInputString[0].isEmpty) {
  //       if (hasOverflow) {
  //         _listInputString[0] = '0';
  //         dollars = int.parse(_listInputString[0]) + 1;
  //       } else {
  //         dollars = 0;
  //       }
  //     } else {
  //       dollars = hasOverflow
  //           ? int.parse(_listInputString[0]) + 1
  //           : int.parse(_listInputString[0]);
  //     }
  //   }
  // }

  // int _overflow(String listInputString) {
  //   var cents;
  //   int parseInputNum =
  //       int.parse(listInputString[0] + listInputString[1].substring(0, 2));
  //   var temp = int.parse(listInputString[1].substring(2, 3));
  //   if (temp >= 5) {
  //     parseInputNum = parseInputNum + 1;
  //     String tempString = parseInputNum.toString();
  //     cents = tempString.length > 1
  //         ? int.parse(
  //             tempString.substring(tempString.length - 2, tempString.length))
  //         : int.parse(
  //             tempString.substring(tempString.length - 1, tempString.length));
  //   } else {
  //     cents = int.parse(listInputString[1].substring(0, 2));
  //   }
  //   return cents;
  // }

  // @override
  // String toString() {
  //   var centStr;
  //   var dollarsStr;
  //   var result;
  //   if (_listInputString[1] == 'isSymbol') {
  //     result = _listInputString[0];
  //   } else {
  //     dollarsStr = dollars.toString();
  //     if (cents.toString().length < 2) {
  //       centStr = '0$cents';
  //     } else {
  //       centStr = cents == 0 ? '00' : cents.toString();
  //     }
  //     if (dollars == 0) {
  //       if (_listInputString[0].contains('-')) {
  //         dollarsStr = '-' + dollars.toString();
  //         _isNegative = true;
  //       }
  //     }
  //     result = '';
  //     // '$dollarsStr \$  $centStr ¢';
  //   }
  //   return result;
  // }

  String additionMoneyObjects(MyMoney myMoney1, MyMoney myMoney2) {
    int tempCents;
    tempCents = (myMoney1.cents + myMoney2.cents);
    if (tempCents >= 100) {
      _listInputString[0] =
          (myMoney1.dollars + myMoney2.dollars + tempCents ~/ 100).toString();
      if ((tempCents % 100).toString().length == 1) {
        _listInputString[1] = '0' + (tempCents % 100).toString();
      } else {
        _listInputString[1] = (tempCents % 100).toString();
      }
    } else {
      _listInputString[1] = tempCents.toString();
      _listInputString[0] = (myMoney1.dollars + myMoney2.dollars).toString();
    }
    String result = '${_listInputString[0]}.${_listInputString[1]}';
    return result;
  }

  String subtractionMoneyObjects(MyMoney myMoney1, MyMoney myMoney2) {
    int tempCents;
    int tempDollars;
    tempCents = (myMoney1.cents - myMoney2.cents);
    tempDollars = (myMoney1.dollars - myMoney2.dollars);

    if (tempCents < 0) {
      if (tempDollars > 0) {
        _listInputString[1] = (100 + tempCents).toString();
        _listInputString[0] = (tempDollars - 1).toString();
      } else {
        _listInputString[1] = (-tempCents).toString();
        if (tempDollars == 0) {
          _listInputString[0] = '-' + tempDollars.toString();
        } else {
          _listInputString[0] = tempDollars.toString();
        }
      }
    } else {
      _listInputString[1] = tempCents.toString();
      _listInputString[0] = tempDollars.toString();
    }
    if (_listInputString[1].length == 1) {
      _listInputString[1] = '0' + _listInputString[1];
    }

    String result = '${_listInputString[0]}.${_listInputString[1]}';
    return result;
  }

  String comparisonMoneyObjects(MyMoney _myMoney1, MyMoney _myMoney2) {
    int myMoney1 = _concatenationOfNumbers(_myMoney1.dollars, _myMoney1.cents);
    print(myMoney1);
    int myMoney2 = _concatenationOfNumbers(_myMoney2.dollars, _myMoney2.cents);
    print(myMoney2);
    String result;
    bool _isLocalNegative = false;
    int tempDollars1, tempDollars2, tempCents1, tempCents2;

    // if (myMoney1._isNegative && myMoney1.dollars == 0) {
    //   tempDollars1 = myMoney1.dollars;
    //   tempCents1 = int.parse('-' + myMoney1.cents.toString());
    //   print(tempDollars1);
    //   print(tempCents1);
    // } else {
    //   tempDollars1 = myMoney1.dollars;
    //   tempCents1 = myMoney1.cents;
    //   if (tempDollars1 < 0) {
    //     _isLocalNegative = true;
    //   }
    //   print(tempDollars1);
    //   print(tempCents1);
    // }
    // if (myMoney2._isNegative && myMoney2.dollars == 0) {
    //   tempDollars2 = myMoney2.dollars;
    //   tempCents2 = int.parse('-' + myMoney2.cents.toString());
    //   print(tempDollars2);
    //   print(tempCents2);
    // } else {
    //   tempDollars2 = myMoney2.dollars;
    //   tempCents2 = myMoney2.cents;
    //   print(tempDollars2);
    //   print(tempCents2);
    // }
    // if (tempDollars1 == tempDollars2) {
    //   if (tempCents1 == tempCents2) {
    //     result = '=';
    //   } else if (tempCents1 > tempCents2) {
    //     result = _isLocalNegative ? '<' : '>';
    //     print(_isLocalNegative);
    //   } else {
    //     result = _isLocalNegative ? '>' : '<';
    //     print(_isLocalNegative);
    //   }
    // } else if (tempDollars1 > tempDollars2) {
    //   result = '>';
    // } else {
    //   result = '<';
    // }
    // print(result);
    return result = '=';
  }
}
