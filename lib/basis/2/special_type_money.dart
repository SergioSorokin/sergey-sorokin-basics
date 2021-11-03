class MyMoney {
  late final int dollars;
  late final int cents;

  List<String> listInputString = [];

  MyMoney({required String inputString}) {
    parseInputString(inputString);
  }

  void parseInputString(String inputString) {
    listInputString = inputString.split('.');
    if (listInputString[0].isNotEmpty || listInputString.length == 1) {
      dollars = int.parse(listInputString[0]);
    } else {
      dollars = 0;
    }
    if (listInputString.length == 2 && listInputString[1].isNotEmpty) {
      cents = int.parse(listInputString[1]);
    } else {
      cents = 0;
    }
  }

  @override
  String toString() {
    var centStr = cents == 0 ? '00' : cents.toString();
    return '$dollars \$  $centStr ¢' '';
  }
}
