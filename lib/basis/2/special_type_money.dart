class MyMoney {
  late final int dollars;
  late final int cents;

  List<String> _listInputString = ['', ''];

  MyMoney({required String inputString}) {
    _parseInputString(inputString);
  }

  void _parseInputString(String inputString) {
    if (inputString.contains('.')) {
      _listInputString = inputString.split('.');
    } else {
      _listInputString[0] = inputString;
      _listInputString[1] = '0';
    }
    var hasOverflow = false;
    if (_listInputString.length > 0 && _listInputString[1].isNotEmpty) {
      if (_listInputString[1].length == 1) {
        cents = int.parse(_listInputString[1]) * 10;
      } else if (_listInputString[1].length > 2) {
        cents = _overflow(_listInputString);
        if (cents == 0) {
          hasOverflow = true;
        }
      } else {
        cents = int.parse(_listInputString[1]);
      }
    } else {
      cents = 0;
    }
    if (_listInputString[0].isEmpty) {
      if (hasOverflow) {
        _listInputString[0] = '0';
        dollars = int.parse(_listInputString[0]) + 1;
      } else {
        dollars = 0;
      }
    } else {
      dollars = hasOverflow
          ? int.parse(_listInputString[0]) + 1
          : int.parse(_listInputString[0]);
    }
  }

  int _overflow(List<String> listInputString) {
    var cents;
    int parseInputNum =
        int.parse(listInputString[0] + listInputString[1].substring(0, 2));
    var temp = int.parse(listInputString[1].substring(2, 3));
    if (temp >= 5) {
      parseInputNum = parseInputNum + 1;
      String tempString = parseInputNum.toString();
      cents = tempString.length > 1
          ? int.parse(
              tempString.substring(tempString.length - 2, tempString.length))
          : int.parse(
              tempString.substring(tempString.length - 1, tempString.length));
    } else {
      cents = int.parse(listInputString[1].substring(0, 2));
    }
    return cents;
  }

  @override
  String toString() {
    var centStr;
    if (cents.toString().length < 2) {
      centStr = '0$cents';
    } else {
      centStr = cents == 0 ? '00' : cents.toString();
    }
    return '$dollars \$  $centStr ¢';
  }
}
