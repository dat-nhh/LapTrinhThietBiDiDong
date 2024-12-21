void main(){
  List<String> list = [
    "Hà Nội", "Huế", "Đà Nẵng", "Nha Trang", "Sài Gòn"
  ];
  List<int> cd = list.map((e) => e.length).toList();
  print(list);
  print(cd);
  cd.forEach((e) {
    print(e*e);
  });
}