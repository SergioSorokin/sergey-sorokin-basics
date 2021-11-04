class MyMoney {
  late final int dollars;
  late final int cents;

  List<String> listInputString = [];

  MyMoney({required String inputString}) {
    parseInputString(inputString);
  }

  void parseInputString(String inputString) {
    listInputString = inputString.split('.');
    var hasOverflow = false;
    if (listInputString.length > 1 && listInputString[1].isNotEmpty) {
      if (listInputString[1].length == 1) {
        cents = int.parse(listInputString[1]) * 10;
      } else if (listInputString[1].length > 2) {
        cents = overflow(listInputString);
        if (cents == 0) {
          hasOverflow = true;
        }
      } else {
        cents = int.parse(listInputString[1]);
      }
    } else {
      cents = 0;
    }
    if (listInputString[0].isEmpty) {
      if (hasOverflow) {
        listInputString[0] = '0';
        dollars = int.parse(listInputString[0]) + 1;
      } else {
        dollars = 0;
      }
    } else {
      dollars = hasOverflow
          ? int.parse(listInputString[0]) + 1
          : int.parse(listInputString[0]);
    }
  }

  int overflow(List<String> listInputString) {
    var cents;
    int parseInputNum =
        int.parse(listInputString[0] + listInputString[1].substring(0, 2));
    var temp = int.parse(listInputString[1].substring(2, 3));
    if (temp >= 5) {
      parseInputNum = parseInputNum + 1;
      String testString = parseInputNum.toString();
      cents = int.parse(
          testString.substring(testString.length - 2, testString.length));
    } else {
      cents = int.parse(listInputString[1].substring(0, 2));
    }
    return cents;
  }

  @override
  String toString() {
    var centStr = cents == 0 ? '00' : cents.toString();
    return '$dollars \$  $centStr ¢' '';
  }
}
