import 'package:dat_nhh_63133655_flutter/fruit_store/models.dart';
import 'package:get/get.dart';

class SimpleControllerSP extends GetxController{
  List<Fruit> _dssp = [];
  List<GH_Item> _gioHang = [];
  List<Fruit> get dssp => _dssp;
  List<GH_Item> get gioHang => _gioHang;
  int get SLMHtrongGH => _gioHang.length;

  //get để truy cập controller
  static SimpleControllerSP get() => Get.find<SimpleControllerSP>();
  static SimpleControllerSP get instance => Get.find<SimpleControllerSP>();

  @override
  void onReady() {
    docDL();
  }

  // @override
  // void onInit() {
  //   _dssp = AppData().dssp;
  //   update(["ListSP"]);
  // }

  Future<void> docDL() async{
    var list = await FruitSnapshot.getAll2();
    _dssp = list.map((fruitSnap) => fruitSnap.fruit).toList();
    update(["ListSP"]);
  }

  themGioHang(Fruit f, {required List<String> updateWidgetId, void Function(int slSP)? function}){
    for(GH_Item item in _gioHang)
      if(item.idSP == f.id) {
        item.sl++;
        if(function!= null)
          function(item.sl);
        return;
      }
    _gioHang.add(GH_Item(idSP: f.id, sl: 1));
    update(updateWidgetId);
  }
}

class FruitStoreBinding extends Bindings{

  @override
  void dependencies() {
    Get.put(SimpleControllerSP());
  }
}

