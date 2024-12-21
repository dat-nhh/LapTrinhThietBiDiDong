import 'dart:math';

import 'package:flutter/material.dart';

List<String> sps = [
  "Xoài", "Mít", "Táo", "Bưởi", "Chuối", "Nho",
  "Ổi", "Me", "Dưa hấu", "Vú sửa", "Mận",
];
class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Trái cây miệt vườn"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.food_bank),
              title: Text(sps[index]),
              subtitle: Text("Mít tơ bít"),
              trailing: Text("${Random().nextInt(100)}.000 VND"),
            );
          },
          separatorBuilder: (context,index) =>
            Divider(thickness: 1.5),
          itemCount: sps.length
      ),
    );
  }
}
