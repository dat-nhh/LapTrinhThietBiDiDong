import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:thu_vien_anh/page_gallery.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async{
            final PermissionState ps = await PhotoManager.requestPermissionExtend();
            if (ps.isAuth) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => GalleryApp(),));
            } else {
              ScaffoldMessenger.of(context).showSnackBar
                (SnackBar(content: Text("Vui lòng cấp quyền để truy cập ứng dụng"),
                duration: Duration(seconds: 5),
                action: SnackBarAction(
                  onPressed: () {
                    ScaffoldMessenger.of(context).clearSnackBars();
                  },
                  label: "Đóng",
                ),
              ));
            }
          },
          child: Text("Cấp quyền ứng dụng"),
        ),
      ),
    );
  }
}
