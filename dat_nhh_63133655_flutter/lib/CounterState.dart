import 'package:flutter/foundation.dart';

class CounterState extends ChangeNotifier{
  int _count = 0;
  int get count => _count;
  tang(){
    _count++;
    notifyListeners();
  }
  giam(){
    _count--;
    notifyListeners();
  }
}