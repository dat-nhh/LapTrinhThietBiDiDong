import 'package:dat_nhh_63133655_flutter/fruit_store/models.dart';
import 'package:get/get.dart';

class FirebaseController extends GetxController{
  final _dssp = <FruitSnapshot>[].obs;
  final _gioHang = <FruitSnapshot>[].obs;

  List<FruitSnapshot> get dssp => _dssp.value;
  List<FruitSnapshot> get gioHang => _gioHang.value;
  int get SLMHtrongGH => _gioHang.length;

  static FirebaseController get instance => Get.find<FirebaseController>();

  @override
  void onReady() {
    _dssp.bindStream(FruitSnapshot.getAll());
  }
}

class FirebaseControllerBindings extends Bindings{

  @override
  void dependencies() {
    Get.put(FirebaseController());
  }
}