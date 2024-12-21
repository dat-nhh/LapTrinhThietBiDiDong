import 'package:dat_nhh_63133655_flutter/rss/controller/rss_controller_simple.dart';
import 'package:dat_nhh_63133655_flutter/rss/model/rss_item_template.dart';
import 'package:dat_nhh_63133655_flutter/rss/pages/webview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RssApp extends StatelessWidget {
  const RssApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: RssBindings(),
      home: PageRss(),
    );
  }
}

class PageRss extends StatelessWidget {
  const PageRss({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${SimpleControllerRss.instance.resourceName}"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: RefreshIndicator(
        onRefresh: () => SimpleControllerRss.instance.readRSS(),
        child: GetBuilder<SimpleControllerRss>(
          id: "listRss",
          init: SimpleControllerRss.instance,
          builder:(controller) {
            List<RSSItem> list = controller.rssList;
            return ListView.separated(
                itemBuilder: (context, index) {
                  var rss = list[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(MyWebPage(url: rss.link!,
                              nameResource: SimpleControllerRss.instance.resourceName
                          ));
                        },
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Image.network("${rss.imgUrl}")
                            ),
                            Expanded(
                                flex: 2,
                                child: Text("${rss.title}", style: TextStyle(color: Colors.blue),)
                            ),
                          ],
                        ),
                      ),
                      Text("${rss.description}"),
                    ],
                  );
                },
                separatorBuilder: (context, index) => Divider(thickness: 1.5,),
                itemCount: list.length,
            );
          },
        ),
      ),
    );
  }
}
