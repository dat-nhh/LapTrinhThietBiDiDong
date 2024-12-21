import 'package:dat_nhh_63133655_flutter/fruit_store/controllers.dart';
import 'package:dat_nhh_63133655_flutter/fruit_store/page_ct_fruitstore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

class AppFruitStore extends StatelessWidget {
  const AppFruitStore({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialBinding: FruitStoreBinding(),
        debugShowCheckedModeBanner: false,
        home: PageHomeFruitStore(),
    );
  }
}

class PageHomeFruitStore extends StatelessWidget {
  const PageHomeFruitStore({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Fruit Store"),
        actions: [
          GetBuilder<SimpleControllerSP>(
            init: SimpleControllerSP.get(),
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
      body: RefreshIndicator(
        onRefresh: () => SimpleControllerSP.instance.docDL(),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: GetBuilder<SimpleControllerSP>(
            init: SimpleControllerSP.get(),
            id: "ListSP",
            builder: (controller) {
              return GridView.extent(
                maxCrossAxisExtent: 300,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                children: controller.dssp.map(
                        (sp) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PageCTFruitStore(sp: sp),
                            ));
                          },
                          child: Card(
                            elevation: 0.5,
                            child: Column(
                              children: [
                                Expanded(
                                    child: sp.anh!=null? Image.network(sp.anh!): Icon(Icons.image),
                                ),
                                Text(sp.ten),
                                Text("${sp.gia} VND", style: TextStyle(color: Colors.red),),
                              ],
                            ),
                          ),
                        )
                ).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
