import 'package:dat_nhh_63133655_flutter/page-home-63133655.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: pageHome(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController contextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("VIP"),
        actions: [
            IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar
                    (SnackBar(content: Text("Cool skeleton with ${contextController.text}"),
                    duration: Duration(seconds: 5),
                    action: SnackBarAction(
                      onPressed: () {
                        ScaffoldMessenger.of(context).clearSnackBars();
                      },
                      label: "Close",
                    ),
                  ));
                },
                icon: Icon(Icons.star))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 300,
                  height: 400,
                  child: Image.network("https://preview.redd.it/b627h5g7y8q91.jpg?width=202&format=pjpg&auto=webp&s=33e36a6ea0f1ac2bb154152bcfe9844e135fe369"),
                ),
              ),
              TextField(
                controller: contextController,
                decoration: InputDecoration(
                  labelText: "Context",
                  hintText: "Nhập nội dung vào đây",
                ),
              )
            ],
          ),
        )
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
        title: Text("Route Management Demo"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Text("Hello"),
      ),
    );
  }
}
