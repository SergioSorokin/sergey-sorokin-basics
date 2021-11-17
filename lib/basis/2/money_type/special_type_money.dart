class MyMoney {
  late final int dollars;
  late final int cents;
  late final int _sign;

  List<String> _listInputString = ['', ''];
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
      _listInputString = _splittingNumbers(_tempNumber);
      dollars = int.parse(_listInputString[0]);
      cents = int.parse(_listInputString[1]);
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
    return _result;
  }

  static int _overflow(List<String> _inputList) {
    var _result;
    var _temp;
    if (_inputList[1].length > 1) {
      _temp = int.parse(_inputList[1].substring(2, 3));
      if (_temp >= 5) {
        _result = int.parse(_inputList[1].substring(0, 2)) + 1;
      } else {
        _result = int.parse(_inputList[1].substring(0, 2));
      }
    } else {
      _result = int.parse(_inputList[1]);
    }

    return _result;
  }

  static List<String> _splittingNumbers(int _tempNumbers) {
    List<String> _result = ['', ''];
    int _localSing;
    _localSing = _tempNumbers.toString().contains('-') ? -1 : 1;
    _tempNumbers = _tempNumbers * _localSing;
    String _tempDollars;
    String _tempCents;
    _tempDollars = ((_tempNumbers ~/ 100) * _localSing).toString();
    _tempCents = (_tempNumbers % 100).toString();
    _tempCents = _tempCents.length == 1 ? '0' + _tempCents : _tempCents;
    _result = [
      _localSing == -1 && _tempDollars == '0' ? '-0' : _tempDollars,
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
    //return ' $dollars\$ $cents¢';
  }

  static MyMoney additionMoneyObjects(MyMoney _myMoney1, MyMoney _myMoney2) {
    int _myNewMoney;
    int _myNewMoney1 =
        _myMoney1._concatenationOfNumbers(_myMoney1.dollars, _myMoney1.cents);
    int _myNewMoney2 =
        _myMoney2._concatenationOfNumbers(_myMoney2.dollars, _myMoney2.cents);
    _myNewMoney = _myNewMoney1 + (_myNewMoney2);
    List<String> newList = _splittingNumbers(_myNewMoney);

    return MyMoney(inputString: '${newList[0]}.${newList[1]}');
  }

  static MyMoney subtractionMoneyObjects(MyMoney _myMoney1, MyMoney _myMoney2) {
    int _myNewMoney;
    int _myNewMoney1 =
        _myMoney1._concatenationOfNumbers(_myMoney1.dollars, _myMoney1.cents);
    int _myNewMoney2 =
        _myMoney2._concatenationOfNumbers(_myMoney2.dollars, _myMoney2.cents);
    if (_myMoney1._sign == -1 || _myMoney2._sign == -1) {
      _myNewMoney = _myNewMoney1 + _myNewMoney2;
    } else {
      _myNewMoney = _myNewMoney1 - _myNewMoney2;
    }
    List<String> newList = _splittingNumbers(_myNewMoney);
    return MyMoney(inputString: '${newList[0]}.${newList[1]}');
  }

  static String comparisonMoneyObjects(MyMoney _myMoney1, MyMoney _myMoney2) {
    var _result;
    int _myNewMoney1 =
        _myMoney1._concatenationOfNumbers(_myMoney1.dollars, _myMoney1.cents);
    int _myNewMoney2 =
        _myMoney2._concatenationOfNumbers(_myMoney2.dollars, _myMoney2.cents);
    if (_myNewMoney1 != _myNewMoney2) {
      _result = _myNewMoney1 > _myNewMoney2 ? '>' : '<';
    } else {
      _result = '=';
    }
    return _result;
  }

  static MyMoney multiplicationMethod(MyMoney _myMoney, String _inputFactor) {
    double _tempInputFactor = double.parse(_inputFactor);
    int _myNewMoney =
        _myMoney._concatenationOfNumbers(_myMoney.dollars, _myMoney.cents);
    List<String> _tempList =
        ((_myNewMoney * _tempInputFactor) / 100).toString().split('.');
    int _tempCents = _overflow(_tempList);
    int _tempResult =
        ((double.parse('${_tempList[0]}.$_tempCents') * 100)).toInt();
    List<String> newList = _splittingNumbers(_tempResult);
    return MyMoney(inputString: '${newList[0]}.${newList[1]}');
  }

  static MyMoney divisionMethod(MyMoney _myMoney, String _inputFactor) {
    print('divisionMethod(MyMoney $_myMoney, String $_inputFactor)');
    double _tempInputFactor = double.parse(_inputFactor);
    int _myNewMoney =
        _myMoney._concatenationOfNumbers(_myMoney.dollars, _myMoney.cents);
    List<String> _tempList =
        ((_myNewMoney / _tempInputFactor) / 100).toString().split('.');
    int _tempCents = _overflow(_tempList);
    int _tempResult =
        ((double.parse('${_tempList[0]}.$_tempCents') * 100)).toInt();
    List<String> newList = _splittingNumbers(_tempResult);
    return MyMoney(inputString: '${newList[0]}.${newList[1]}');
  }

  static MyMoney roundingMethod(
      MyMoney _myMoney, int _rounding, bool _isoOverflow) {
    int _tempResult;
    int _myNewMoney =
        _myMoney._concatenationOfNumbers(_myMoney.dollars, _myMoney.cents);
    var tempTest = _myNewMoney / _rounding;
    List<String> _tempList = tempTest.toString().split('.');
    int tempInt = int.parse(_tempList[1].substring(0, 1));
    _isoOverflow && tempInt >= 5
        ? _tempResult = _myNewMoney - (_myNewMoney % _rounding) + _rounding
        : _tempResult = _myNewMoney - (_myNewMoney % _rounding);

    List<String> newList = _splittingNumbers(_tempResult);

    return MyMoney(inputString: '${newList[0]}.${newList[1]}');
  }
}

class MoneyCents {
  late final int cents;
  late final int _sign;

  MoneyCents({required String inputString}) {
    _createMoneyObject(inputString);
  }

  MoneyCents.fromCents(int cents) {
    _createMoneyObject(_splitting(cents.toString()));
  }

  List<String> _listInputString = ['', ''];

  void _createMoneyObject(String inputString) {
    _sign = inputString.contains('-') ? -1 : 1;
    _listInputString = _checkingCurrentInput(inputString).split('.');
    _listInputString = _overflow(_listInputString);
    cents = _listInputString[0] == '0' && _sign == -1
        ? int.parse(_concatenationOfValue(
                _listInputString[0], _listInputString[1])) *
            _sign
        : int.parse(
            _concatenationOfValue(_listInputString[0], _listInputString[1]));
    print(cents);
    _listInputString = _splitting(cents.toString()).split('.');
    print(_listInputString);
    // _listInputString = _overflow(_listInputString);
  }

  String _checkingCurrentInput(String _inputString) {
    String _result;
    List<String> _tempList = ['', ''];
    _tempList = _inputString.contains('.')
        ? _inputString.split('.')
        : ['$_inputString', '0'];
    // if (_inputString.contains('.')) {
    //   _tempList = _inputString.split('.');
    // } else {
    //   _tempList = ['$_inputString', '0'];
    // }
    _tempList[0] = _tempList[0] == '-' && _tempList[0].length == 1
        ? '-0'
        : _tempList[0].isEmpty
            ? '0'
            : _tempList[0];
    _tempList[1] = _tempList[1].isEmpty ? '0' : _tempList[1];
    _result = '${_tempList[0]}.${_tempList[1]}';
    return _result;
  }

//todo: maybe refactor to extension method
  List<String> _overflow(List<String> _listInputString) {
    List<String> _result = ['', ''];
    int _tempDollars = int.parse(_listInputString[0]);
    if (_listInputString[1] == '0') {
      _listInputString[1] = '00';
    } else {
      int _tempCents = _listInputString[1].length < 2
          ? int.parse(_listInputString[1]) * 10
          : int.parse(_listInputString[1].substring(0, 2));
      var _temp = _listInputString[1].length > 2
          ? int.parse(_listInputString[1].substring(2, 3))
          : 0;
      if (_temp >= 5) {
        _tempCents = _tempCents + 1;
        if (_tempCents > 99) {
          _tempDollars = _listInputString[0].contains('-')
              ? _tempDollars + 1 * -1
              : _tempDollars + 1;
          _tempCents = _tempCents % 100;
        }
      }
      _listInputString[1] = _tempCents.toString();
    }
    _listInputString[1] = _listInputString[1].length == 1
        ? '0' + _listInputString[1]
        : _listInputString[1];
    _listInputString[0] = _tempDollars == 0 && _listInputString[0] == '-0'
        ? _listInputString[0]
        : _tempDollars.toString();
    _result = ['${_listInputString[0]}', '${_listInputString[1]}'];
    return _result;
  }

  String _concatenationOfValue(String _dollars, String _cents) {
    String _result;
    _result = _dollars + _cents;
    return _result;
  }

  String _splitting(String _cents) {
    String _result = '';
    List<String> _tempList = (int.parse(_cents) * 0.01).toString().split('.');

    _tempList[1] = _tempList[1].length < 2
        ? _tempList[1] == '0'
            ? '00'
            : (int.parse(_tempList[1]) * 10).toString()
        : _tempList[1];
    _result = '${_tempList[0]}.${_tempList[1]}';
    return _result;
  }

  @override
  String toString() {
    var _result;
    // _result = !_isSymbol
    //     ? '${_listInputString[0]}\$ ${_listInputString[1]}¢'
    //     : _listInputString[0];
    return '${_listInputString[0]}\$ ${_listInputString[1]}¢';
    //return ' $dollars\$ $cents¢';
  }

  // @override
  // String toString() => '$cents';

  operator +(MoneyCents other) => MoneyCents.fromCents(cents + other.cents);

  operator -(MoneyCents other) => MoneyCents.fromCents(cents - other.cents);

  operator *(MoneyCents other) => MoneyCents.fromCents(cents * other.cents);

  operator /(MoneyCents other) => MoneyCents.fromCents(cents ~/ other.cents);

  operator ~/(MoneyCents other) => MoneyCents.fromCents(cents ~/ other.cents);
}

void test(MoneyCents m1, MoneyCents m2) {
  print('test:');
  print(m1 + m2);
  print(m1 - m2);
  print(m1 * m2);
  print(m1 / m2);
}
