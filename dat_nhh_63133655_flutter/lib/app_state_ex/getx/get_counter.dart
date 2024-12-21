import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController{
  final _count = 0.obs;

  int get count => _count.value;

  void tang(){
    _count.value++;
  }
}

class PageGetxCounter extends StatelessWidget {
  PageGetxCounter({super.key});
  final c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Getx Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text("${c.count}")),
            GetX<Controller>(
              builder: (controller) => Text("${controller.count}"),
            ),
            ElevatedButton(
                onPressed: () {
                  c.tang();
                },
                child: Text("+"),
            )
          ],
        ),
      ),
    );
  }
}
