import 'dart:math';
import 'dart:ui';

import 'package:dat_nhh_63133655_flutter/fruit_store/controllers.dart';
import 'package:dat_nhh_63133655_flutter/fruit_store/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

class PageCTFruitStore extends StatelessWidget {
  PageCTFruitStore({super.key, required this.sp});
  Fruit sp;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width*0.9;
    double r = Random().nextInt(50)/10;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Product information"),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: w,
                child: Image.network(sp.anh!),
              ),
            ),
            Text("Tên sản phẩm: " + sp.ten),
            Text("Mô tả: " + sp.moTa!?? "Không có mô tả"),
            Text("Giá: ${sp.gia} VND", style: TextStyle(color: Colors.red),),
            Text("Đánh giá sản phẩm"),
            Row(
              children: [
                RatingBar.builder(
                  initialRating: r,
                  minRating: 0,
                  maxRating: 5,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 25,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                Text("  ${r}", style: TextStyle(color: Colors.orange),),
                Text("  ${Random().nextInt(50)} đánh giá"),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_shopping_cart),
        onPressed: () {
          SimpleControllerSP.get().themGioHang(sp, updateWidgetId: ["gioHang"], 
              function: (slSP) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Đã có ${slSP} ${sp.ten} trong giỏ hàng"))
                );
              },
          );
        },
      ),
    );
  }
}
