import 'package:dat_nhh_63133655_flutter/fruit_store/models.dart';
import 'package:dat_nhh_63133655_flutter/fruit_store/page_ctsp_admin.dart';
import 'package:dat_nhh_63133655_flutter/fruit_store/page_update_admin.dart';
import 'package:dat_nhh_63133655_flutter/fruit_store/storage_image_helper.dart';
import 'package:dat_nhh_63133655_flutter/fruit_store/widget_connect_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class FruitStoreAdmin extends StatelessWidget {
  const FruitStoreAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        errorMessage: "Lỗi",
        connectingMessage: "Đang kết nối",
        builder: (context) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: PageDSSP_Admin(),
        ),
    );
  }
}

class PageDSSP_Admin extends StatelessWidget {
  const PageDSSP_Admin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DSSP"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: StreamBuilder<List<FruitSnapshot>>(
        stream: FruitSnapshot.getAll(),
        builder: (context, snapshot) {
          if(snapshot.hasError)
            return Center(child: Text("Lỗi quài"),);
          if(!snapshot.hasData)
            return Center(child: CircularProgressIndicator(),);
          List<FruitSnapshot> list = snapshot.data!;
          return ListView.separated(
              itemBuilder: (context, index) {
                FruitSnapshot fs = list[index];
                return Slidable(
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        // An action can be bigger than the others.
                        flex: 2,
                        onPressed: (context) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PageCapNhatSP_Admin(fruitSnapshot: fs),));
                        },
                        backgroundColor: Colors.lightGreenAccent,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Cập nhật',
                      ),
                      SlidableAction(
                        // An action can be bigger than the others.
                        flex: 2,
                        onPressed: (context) {
                          fs.xoa();
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Xóa',
                      ),
                    ],
                  ),
                  child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Image.network(fs.fruit.anh!),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("ID: ${fs.fruit.id}"),
                              Text("Tên: ${fs.fruit.ten}"),
                              Text("Giá: ${fs.fruit.gia}"),
                              Text("Mô tả: ${fs.fruit.moTa}"),
                            ],
                          ),
                        ),
                      ],
                  ),
                );
              },
              separatorBuilder: (context,index) =>
                  Divider(thickness: 1.5),
              itemCount: list.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PageCTSP_Admin(),));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

