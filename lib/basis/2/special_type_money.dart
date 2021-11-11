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
    _temp = int.parse(_inputList[1].substring(2, 3));
    if (_temp >= 5) {
      _result = int.parse(_inputList[1].substring(0, 2)) + 1;
    } else {
      _result = int.parse(_inputList[1].substring(0, 2));
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

  static String additionMoneyObjects(MyMoney _myMoney1, MyMoney _myMoney2) {
    var _result = '';
    int _myNewMoney;
    int _myNewMoney1 =
        _myMoney1._concatenationOfNumbers(_myMoney1.dollars, _myMoney1.cents);
    int _myNewMoney2 =
        _myMoney2._concatenationOfNumbers(_myMoney2.dollars, _myMoney2.cents);
    _myNewMoney = _myNewMoney1 + (_myNewMoney2);
    List<String> newList = _splittingNumbers(_myNewMoney);
    _result = '${newList[0]}.${newList[1]}';
    print(newList);
    return _result;
  }

  static String subtractionMoneyObjects(MyMoney _myMoney1, MyMoney _myMoney2) {
    var _result = '';
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
    _result = '${newList[0]}.${newList[1]}';
    return _result;
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
    // print(_myMoney1 + _myMoney2);
    return _result;
  }

  static MyMoney multiplicationMethod(MyMoney _myMoney, String inputFactor) {
    double _tempInputFactor = double.parse(inputFactor);
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
/* //todo: understand this approach
 operator +(MyMoney other) {
    int _myNewMoney1 = this._concatenationOfNumbers(this.dollars, this.cents);
    int _myNewMoney2 =
        other._concatenationOfNumbers(other.dollars, other.cents);

    int _myNewMoney = _myNewMoney1 + _myNewMoney2;

    return MyMoney.fromConcatenatedInt(_myNewMoney);
  }

  MyMoney.fromConcatenatedInt(int myNewMoney) {
    dollars = myNewMoney ~/ 100;
    cents = myNewMoney % 100;
    _sign = myNewMoney >= 0 ? 1 : -1;
  }*/
}
