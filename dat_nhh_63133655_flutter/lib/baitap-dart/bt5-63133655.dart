import 'dart:math';

Future<int> lateNum()async{
  //Note: Future<int> == int + await
  int num = await Future.delayed(
      Duration(seconds: 3),
      () => Random().nextInt(100),
  );
  return num;
}

void main()async{
  //Cach 1
  print("Đợi...");
  int num = await lateNum();
  if(num%2==0)
    print("$num chẵn");
  else print("$num lẻ");
  //Cach 2
  print("Đợi tiếp...");
  lateNum().then((value) {
    if(value%2==0)
      print("$value chẵn");
    else print("$value lẻ");
  });
  print("Hết"); //Cach 2 ngu
}