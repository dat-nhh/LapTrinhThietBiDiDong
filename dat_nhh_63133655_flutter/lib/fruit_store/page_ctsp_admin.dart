import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dat_nhh_63133655_flutter/fruit_store/models.dart';
import 'package:dat_nhh_63133655_flutter/fruit_store/storage_image_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PageCTSP_Admin extends StatefulWidget {
  const PageCTSP_Admin({super.key});

  @override
  State<PageCTSP_Admin> createState() => _PageCTSP_AdminState();
}

class _PageCTSP_AdminState extends State<PageCTSP_Admin> {
  XFile? _xFile;
  TextEditingController txtId = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtGia = TextEditingController();
  TextEditingController txtMoTa = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm sản phẩm"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: w*0.8,
                height: w*0.8*2/3,
                child: _xFile == null ? Icon(Icons.image) : Image.file(File(_xFile!.path)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                      onPressed: () async{
                        _xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                        if(_xFile!=null)
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
                    onPressed: () async{
                      showSnackBar(context, thongbao: "Đang thêm...", giay: 5);
                      if(_xFile!=null)
                        uploadImage(
                            imgPath: _xFile!.path,
                            folders: ["fruit_app"],
                            fileName: "${txtId.text}.jpeg"
                        ).then(
                                (url) async{
                                  Fruit f = Fruit(
                                    id: txtId.text, 
                                    ten: txtTen.text, 
                                    gia: int.parse(txtGia.text), 
                                    moTa: txtMoTa.text,
                                    anh: url
                                  );
                                  await FruitSnapshot.themMoi(f);
                                  showSnackBar(context, thongbao: "Đã thêm", giay: 5);
                                }
                        ).catchError((error) {
                          print(error.toString());
                          showSnackBar(context, thongbao: "Lỗi quài", giay: 3);
                        });
                    },
                    child: Text("Thêm")
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, {required String thongbao, required int giay}) {
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

