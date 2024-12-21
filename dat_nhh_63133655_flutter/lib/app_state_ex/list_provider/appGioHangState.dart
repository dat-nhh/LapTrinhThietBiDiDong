import 'package:flutter/foundation.dart';

class AppGioHangState extends ChangeNotifier{
  List<String> _dssp = [
    "Xoài", "Mít", "Táo", "Bưởi", "Chuối", "Nho",
    "Ổi", "Me", "Dưa hấu", "Nhãn", "Mận",
  ];
  List<int> _gia = [
    10000, 50000, 5000, 20000, 15000, 18000,
    7000, 3000, 100000, 9000, 13000,
  ];
  int _tongGia = 0;
  List<int> _gioHang = [];
  int _soLuongMHGH = 0;
  List<String> get dssp => _dssp;
  List<int> get gioHang => _gioHang;
  int get soLuongMHGH => _gioHang.length;
  List<int> get gia => _gia;
  int get tongGia => _tongGia;
  themVaoGH(int index){
    if(ktraMHcotrongGH(index) == false) {
      _tongGia+=_gia[index];
      _gioHang.add(index);
      notifyListeners();
    }
  }
  xoaKhoiGH(int index){
    _tongGia-=_gia[_gioHang[index]];
    _gioHang.removeAt(index);
    notifyListeners();
  }
  bool ktraMHcotrongGH(int index){
    for(int i=0; i<gioHang.length; i++)
      if(gioHang[i] == index)
        return true;
    return false;
  }
}