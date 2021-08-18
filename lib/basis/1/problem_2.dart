void main() {
  const maxNum = 4000000;
  int countNum = 1;
  int varFirst = 1;
  int varSecond = 0;
  int result = 0;

  while (countNum < maxNum) {
    varSecond = countNum + varFirst;
    countNum = varFirst;
    varFirst = varSecond;
    if (countNum % 2 == 0) {
      result = result + countNum;
    }
  }
  print(result);
}
