import 'package:dat_nhh_63133655_flutter/app_state_ex/list_provider/appGioHangState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class GioHangApp extends StatelessWidget {
  const GioHangApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppGioHangState(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: GioHangHomePage(),
        ),
    );
  }
}

class GioHangHomePage extends StatelessWidget {
  const GioHangHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var c = context.watch<AppGioHangState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Trái cây"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: badges.Badge(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GioHang())
                );
              },
              badgeContent: Text('${c.soLuongMHGH}'),
              child: Icon(Icons.shopping_bag_outlined),
            ),
          )
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("${c.dssp[index]}"),
              subtitle: Text(c.gia[index].toString() + " VND"),
              trailing: IconButton(
                  icon: c.ktraMHcotrongGH(index) == false? Icon(Icons.add) : Icon(Icons.check),
                  onPressed: () {
                      var appState = context.read<AppGioHangState>();
                      appState.themVaoGH(index);
                  },
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
            thickness: 1.5,
          ),
          itemCount: c.dssp.length,
      ),
    );
  }
}

class GioHang extends StatelessWidget {
  const GioHang({super.key});

  @override
  Widget build(BuildContext context) {
    var c = context.watch<AppGioHangState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Giỏ hàng"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${c.dssp[c.gioHang[index]]}"),
                  subtitle: Text(c.gia[c.gioHang[index]].toString() + " VND"),
                  trailing: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      var appState = context.read<AppGioHangState>();
                      appState.xoaKhoiGH(index);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                thickness: 1.5,
              ),
              itemCount: c.gioHang.length,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Tổng số tiền: "),
              Text(c.tongGia.toString() + " VND", style: TextStyle(color: Colors.red),),
            ],
          )
        ],
      ),
    );
  }
}

