import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String? data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trang 1"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          children: [
            Text(data?? "Đợi..."),
            ElevatedButton(
              child: Text("Xin chào trang 2"),
              onPressed: () async{
                data = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SecondPage(data: "Xin chào"),)
                );
                setState(() {

                });
              },

            ),
            ElevatedButton(
                child: Text("Không gửi gì cho trang 2"),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SecondPage(),)
                );
              },
            ),
          ],
        )
      )
    );
  }
}

class SecondPage extends StatefulWidget {
  final String? data;
  const SecondPage({super.key, this.data});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Trang 2"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
            child: Column(
              children: [
                Text(widget.data?? "Không có gì hết"),
                ElevatedButton(
                  child: Text("Về trang 1"),
                  onPressed: () {
                    Navigator.of(context).pop("Cảm ơn");
                    },
                ),
              ],
            )
        )
    );
  }
}
