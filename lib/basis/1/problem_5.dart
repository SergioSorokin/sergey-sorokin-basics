void main() {
  var num = 1;
  var xNum = num;
  while (num > 0) {
    if (num % xNum == 0) {
      xNum = xNum + 1;
      if (xNum == 20) {
        print(num);
        // break;
        num = 0;
      }
    } else {
      num = num + 1;
      xNum = 1;
    }
  }
}
