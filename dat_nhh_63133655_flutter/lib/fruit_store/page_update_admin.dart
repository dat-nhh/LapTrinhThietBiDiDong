import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dat_nhh_63133655_flutter/fruit_store/models.dart';
import 'package:dat_nhh_63133655_flutter/fruit_store/storage_image_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PageCapNhatSP_Admin extends StatefulWidget {
  PageCapNhatSP_Admin({super.key, required this.fruitSnapshot});
  FruitSnapshot fruitSnapshot;

  @override
  State<PageCapNhatSP_Admin> createState() => _PageCapNhatSP_AdminState();
}

class _PageCapNhatSP_AdminState extends State<PageCapNhatSP_Admin> {
  XFile? _xFile;
  TextEditingController txtId = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtGia = TextEditingController();
  TextEditingController txtMoTa = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm sản phẩm"),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: w * 0.8,
                height: w * 0.8 * 2 / 3,
                child: _xFile == null ? Image.network(widget.fruitSnapshot.fruit.anh!) : Image.file(
                    File(_xFile!.path)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      _xFile = await ImagePicker().pickImage(
                          source: ImageSource.gallery);
                      if (_xFile != null)
                        setState(() {

                        });
                    },
                    child: Text("Chọn ảnh")
                ),
              ],
            ),
            TextField(
              controller: txtId,
              decoration: InputDecoration(
                labelText: "ID",
              ),
            ),
            TextField(
              controller: txtTen,
              decoration: InputDecoration(
                labelText: "Tên",
              ),
            ),
            TextField(
              controller: txtGia,
              decoration: InputDecoration(
                labelText: "Giá",
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: txtMoTa,
              decoration: InputDecoration(
                labelText: "Mô tả",
              ),
              maxLines: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      String? imgurl;
                      Fruit f = Fruit(
                          id: txtId.text,
                          ten: txtTen.text,
                          gia: int.parse(txtGia.text),
                          moTa: txtMoTa.text
                      );
                      if (_xFile != null) {
                        showSnackBar(context, thongbao: "Đang lưu...", giay: 5);
                        imgurl = await uploadImage(
                            imgPath: _xFile!.path,
                            folders: ["fruit_app"],
                            fileName: "${txtId.text}.jpeg"
                        );
                        if(imgurl!=null){
                          f.anh = imgurl;
                          widget.fruitSnapshot.capNhat(f);
                        }
                        else{
                          showSnackBar(context, thongbao: "Đã lưu", giay: 3);
                          f.anh = widget.fruitSnapshot.fruit.anh;
                          widget.fruitSnapshot.capNhat(f);
                        }
                      }
                    },
                    child: Text("Lưu"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  @override
  void initState() {
    txtId.text = widget.fruitSnapshot.fruit.id;
    txtTen.text = widget.fruitSnapshot.fruit.ten;
    txtGia.text = widget.fruitSnapshot.fruit.gia.toString();
    txtMoTa.text = widget.fruitSnapshot.fruit.moTa?? "";
  }

  void showSnackBar(BuildContext context,
      {required String thongbao, required int giay}) {
    ScaffoldMessenger.of(context).showSnackBar
      (SnackBar(content: Text(thongbao),
      duration: Duration(seconds: giay),
      action: SnackBarAction(
        onPressed: () {
          ScaffoldMessenger.of(context).clearSnackBars();
        },
        label: "Close",
      ),
    ));
  }
}
