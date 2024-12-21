import 'package:cloud_firestore/cloud_firestore.dart';

class Fruit{
  String id,ten;
  int gia;
  String? anh;
  String? moTa;

  Fruit({required this.id, required this.ten, required this.gia, this.anh, this.moTa});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'ten': this.ten,
      'gia': this.gia,
      'anh': this.anh,
      'moTa': this.moTa,
    };
  }

  factory Fruit.fromJson(Map<String, dynamic> map) {
    return Fruit(
      id: map['id'] as String,
      ten: map['ten'] as String,
      gia: map['gia'] as int,
      anh: map['anh'] as String,
      moTa: map['moTa'] as String,
    );
  }
}

class FruitSnapshot{
  Fruit fruit;
  DocumentReference ref;

  FruitSnapshot({
    required this.fruit,
    required this.ref,
  });

  Map<String, dynamic> toMap() {
    return {
      'fruit': this.fruit,
      'ref': this.ref,
    };
  }

  factory FruitSnapshot.fromMap(DocumentSnapshot docSnap) {
    return FruitSnapshot(
      fruit: Fruit.fromJson(docSnap.data() as Map<String, dynamic>),
      ref: docSnap.reference,
    );
  }

  Future<void> capNhat(Fruit fruit){
    return ref.update(fruit.toJson());
  }
  
  static Future<DocumentReference> themMoi(Fruit fruit){
    return FirebaseFirestore.instance.collection("Fruit")
        .add(fruit.toJson());
  }

  Future<void> xoa(){
    return ref.delete();
  }

  //Truy vấn dữ liệu tgian thật
  static Stream<List<FruitSnapshot>> getAll(){
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("Fruit")
        .snapshots();
    return sqs.map(
      (qs) => qs.docs.map(
        (docSnap) => FruitSnapshot.fromMap(docSnap)
      ).toList());
  }

  //Truy vấn dữ liệu 1 lần
  static Future<List<FruitSnapshot>> getAll2() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("Fruit")
        .get();
    return qs.docs.map(
            (docSnap) => FruitSnapshot.fromMap(docSnap)
          ).toList();
  }
}

class GH_Item{
  String idSP;
  int sl;

  GH_Item({required this.idSP, required this.sl});
}

Map<String, String> images = {
  "xoai" : "https://i.imgur.com/B1MSN2Y.jpeg",
  "tao" : "https://www.lottemart.vn/media/catalog/product/cache/0x0/0/4/0400289120008-4.jpg.webp",
  "mit" : "https://www.lottemart.vn/media/catalog/product/cache/0x0/2/0/2051320000001-1.jpg.webp",
  "man" : "https://www.lottemart.vn/media/catalog/product/cache/0x0/2/0/2037890000009-1.jpg.webp",
  "chuoi" : "https://www.lottemart.vn/media/catalog/product/cache/0x0/2/0/2039350000000.jpg.webp",
  "dua hau" : "https://bizweb.dktcdn.net/thumb/1024x1024/100/433/551/products/duahau-8f1ec21c5e964cefba567d3a04a15c40-master.jpg?v=1631110985170",
  "sau rieng" : "https://storage.googleapis.com/mm-online-bucket/ecommerce-website/uploads/media/66573.jpg",
  "cam" : "https://lh3.googleusercontent.com/proxy/Txj6h1pkAd8bu_D2DJ2L4m55A-wBWqIcZNvFQ37JrL8uw_GKmGSsneNcbKJa4NrUFl2DNvZQe-cTuhBeT3LOA5vcq9z0FYWQxIs51b0uSQ",
  "nho" : "https://bizweb.dktcdn.net/thumb/grande/100/390/808/products/nho-xanh-autumn-crisp-uc.jpg?v=1632330310953",
  "chom chom" : "https://travinhtrade.vn/DesktopModules/SGD_TRAVINH/Images/sanpham/chom-chom-ngon_202411311317.jpg",
};

class AppData{
  final List<Fruit> _dssp = [
    Fruit(id: "01", ten: "Xoài", gia: 25000, anh: images["xoai"], moTa: "Xoài ngon, sạch nhất Việt Nam"),
    Fruit(id: "02", ten: "Táo", gia: 15000, anh: images["tao"], moTa: "Táo ngon, sạch nhất Việt Nam"),
    Fruit(id: "03", ten: "Mít", gia: 40000, anh: images["mit"], moTa: "Mít ngon, sạch nhất Việt Nam"),
    Fruit(id: "04", ten: "Mận", gia: 20000, anh: images["man"], moTa: "Mận ngon, sạch nhất Việt Nam"),
    Fruit(id: "05", ten: "Chuối", gia: 19000, anh: images["chuoi"], moTa: "Chuối ngon, sạch nhất Việt Nam"),
    Fruit(id: "06", ten: "Dưa Hấu", gia: 50000, anh: images["dua hau"], moTa: "Dưa Hấu ngon, sạch nhất Việt Nam"),
    Fruit(id: "07", ten: "Sầu riêng", gia: 59000, anh: images["sau rieng"], moTa: "Sầu riêng ngon, sạch nhất Việt Nam"),
    Fruit(id: "08", ten: "Cam", gia: 24000, anh: images["cam"], moTa: "Cam ngon, sạch nhất Việt Nam"),
    Fruit(id: "09", ten: "Nho", gia: 10000, anh: images["nho"], moTa: "Nho ngon, sạch nhất Việt Nam"),
    Fruit(id: "10", ten: "Chôm chôm", gia: 14000, anh: images["chom chom"], moTa: "Chôm chôm ngon, sạch nhất Việt Nam"),
  ];
  List<Fruit> get dssp => _dssp;
}