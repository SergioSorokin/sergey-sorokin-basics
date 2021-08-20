void main() {
  int inputNum = 999;
  int countNum = inputNum;
  int result = 0;
  int result1 = 0;
  int result1rev = 0;

  while (countNum >= inputNum - 100) {
    if (countNum == inputNum - 100) {
      inputNum = inputNum - 1;
      countNum = inputNum;
    } else {
      result = inputNum * countNum;
      if ((result1rev = result % 10) ==
          (result1 = (result % 1000000) ~/ 100000)) {
        if ((result1rev = (result % 100) ~/ 10) ==
            (result1 = (result % 100000) ~/ 10000)) {
          if ((result1rev = (result % 1000) ~/ 100) ==
              (result1 = (result % 10000) ~/ 1000)) {
            print('$inputNum * $countNum');
            print('$result is the largest palindrome');
            break;
          }
        }
      }

      countNum--;
    }
  }
}
