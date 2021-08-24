void main() {
  var num = 1;
  var x = 1;
 while(num>0) {
    if (num % x == 0) {
      x++;
      if(x == 20){
        print(num);
        break;
      }
    }else{
      num++;
      x = 1;
    }
  }
}
