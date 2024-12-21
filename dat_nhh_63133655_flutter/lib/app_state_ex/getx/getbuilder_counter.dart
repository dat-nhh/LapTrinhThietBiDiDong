import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Controller extends GetxController{
  int _counter = 0;
  int get counter => _counter;
  static Controller get(String tag){
    return Get.find(tag: tag);
  }
  void tang1(){
    _counter++;
    update(["01"]);
  }
  void tang2(){
    _counter++;
    update(["02"]);
  }
}
class SimpleStateBindings extends Bindings{


  @override
  void dependencies() {
    // Get.lazyPut(() => Controller(),);
    Get.put(Controller(), permanent: true, tag: "tag");
  }
}

class PageSimpleState extends StatelessWidget {
  PageSimpleState({super.key});
  // final c = Get.put<Controller>(Controller(), permanent: true, tag: "tag");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple State Demo"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: (){
                      //Get.find<Controller>(tag: "tag").tang2();
                      Controller.get("tag").tang1();
                    },
                    child: Text("+ 01")
                ),
                GetBuilder(
                    init: Controller.get("tag"), //== Get.find<Controller>(tag: "tag")
                    tag: "tag",
                    id: "01",
                    builder: (controller) => Text("${controller.counter}"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: (){
                      //Get.find<Controller>(tag: "tag").tang2();
                      Controller.get("tag").tang2();
                    },
                    child: Text("+ 02")
                ),
                GetBuilder(
                  init: Controller.get("tag"), //== Get.find<Controller>(tag: "tag")
                  tag: "tag",
                  id: "02",
                  builder: (controller) => Text("${controller.counter}"),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(PageNext());
        },
        child: Text("Next"),
      ),
    );
  }
}
class PageNext extends StatelessWidget {
  const PageNext({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route Management"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Text("Hello"),
      ),
    );
  }
}

class SimpleStateHome extends StatelessWidget {
  const SimpleStateHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Binding Demo"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            Get.to(PageSimpleState(), binding: SimpleStateBindings());
          },
          child: Text("GetBuilder"),
        ),
      ),
    );
  }
}
