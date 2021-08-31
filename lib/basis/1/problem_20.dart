void main() {
  String resultStr = '100';
  String factorStr = '';
  String resultFactorStr = '';
  int factor = 99;
  int factor1 = 0;
  int term = 0;
  int temp = 0;
  int parse = 0;
  while (factor > 1) {
    for (var count = resultStr.length; count >= 0; count--) {
      if (count > 0) {
        parse = int.parse(resultStr[count - 1]);
        factor1 = (factor * parse) + temp;
        factorStr = (factor1 % 10).toString();
        resultFactorStr = factorStr + resultFactorStr;
        temp = factor1 % 1000 ~/ 10;
      } else {
        resultFactorStr = temp.toString() + resultFactorStr;
        temp = 0;
      }
    }
    resultStr = resultFactorStr;
    resultFactorStr = '';
    factor--;
  }
  for (var count = resultStr.length; count > 0; count--) {
    parse = int.parse(resultStr[count - 1]);
    term = term + parse;
  }
  print(term);
}
