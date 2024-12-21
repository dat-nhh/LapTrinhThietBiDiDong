import 'package:dat_nhh_63133655_flutter/fruit_store/firebase_controller.dart';
import 'package:dat_nhh_63133655_flutter/fruit_store/widget_connect_firebase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

class FruitFirebaseApp extends StatelessWidget {
  const FruitFirebaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        errorMessage: "Lỗi kết nối Firebase",
        connectingMessage: "Đang kết nối...",
        builder: (context) {
          return GetMaterialApp(
            initialBinding: FirebaseControllerBindings(),
            debugShowCheckedModeBanner: false,
            home: PageHomeFruitFirebase(),
          );
        }
    );
  }
}

class PageHomeFruitFirebase extends StatelessWidget {
  const PageHomeFruitFirebase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Fruit Store Firabase"),
        actions: [
          GetBuilder<FirebaseController>(
            init: FirebaseController.instance,
            id: "gioHang",
            builder: (controller) => Padding(
              padding: const EdgeInsets.only(right: 20),
              child: badges.Badge(
                showBadge: controller.SLMHtrongGH>0,
                child: Icon(Icons.shopping_bag_outlined),
                badgeContent: Text('${controller.SLMHtrongGH}'),
              ),
            ),
          ),
        ],
      ),
      body: GetX<FirebaseController>(
        init: FirebaseController.instance,
        builder: (controller) {
          var list = controller.dssp;
          return GridView.extent(
            maxCrossAxisExtent: 300,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            children: list.map((FruitSnap) => GestureDetector(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => PageCTFruitStore(sp: FruitSnap),
                // ));
              },
              child: Card(
                elevation: 0.5,
                child: Column(
                  children: [
                    Expanded(
                      child: FruitSnap.fruit.anh!=null? Image.network(FruitSnap.fruit.anh!): Icon(Icons.image),
                    ),
                    Text(FruitSnap.fruit.ten),
                    Text("${FruitSnap.fruit.gia} VND", style: TextStyle(color: Colors.red),),
                  ],
                ),
              ),
            )
            ).toList(),

          );
        },
      ),
    );
  }
}


