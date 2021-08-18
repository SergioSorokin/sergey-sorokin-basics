void main() {
  const int maxNum = 1000;
  int counterNum = 0;
  int sum = 0;
  while (counterNum < maxNum) {
    if (counterNum % 3 == 0 || counterNum % 5 == 0) {
      sum = sum + counterNum;
    }
    counterNum = counterNum + 1;
  }
  print(sum);
}
