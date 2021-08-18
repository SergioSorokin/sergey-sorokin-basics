void main() {
  const num longNum = 600851475143;
  const num limiter = 2;
  num counFirst = limiter;
  num counSecond;
  num divider = 0;
  num result = 0;

  while (counFirst < longNum) {
    counFirst = counFirst + 1;
    counSecond = limiter;
    if (longNum % counFirst == 0) {
      divider = longNum / counFirst;
      while (counSecond < divider) {
        if (divider % counSecond != 0) {
          counSecond = counSecond + 1;
          if (counSecond == divider) {
            result = divider;
            counFirst = longNum;
          }
        } else {
          counSecond = divider;
        }
      }
    }
  }
  print(result);
}
