import 'package:flutter/material.dart';
import 'package:huy_dat_firebase/model.dart';

class PageSinhVien extends StatelessWidget {
  const PageSinhVien({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("DS Sinh Vien"),
      ),
      body: StreamBuilder<List<SinhVienSnapshot>>(
        stream: SinhVienSnapshot.getAll(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
              return Center(
                child: Text("Lỗi: ${snapshot.error}", style: TextStyle(color: Colors.red),),
              );
          }
          else{
            if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
            else{
              var list = snapshot.data!;
              return ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                    leading: Text("${index +1}"),
                    title: Text("${list[index].sv.ten}"),
                  ),
                  separatorBuilder: (context, index) => Divider(thickness: 1.5,),
                  itemCount: list.length
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const PageChiTietSV()));
        },
      ),
    );
  }
}

class PageChiTietSV extends StatefulWidget {
  const PageChiTietSV({super.key});

  @override
  State<PageChiTietSV> createState() => _PageChiTietSVState();
}

class _PageChiTietSVState extends State<PageChiTietSV> {
  var txtId = TextEditingController();
  var txtTen = TextEditingController();
  var txtNgaySinh = TextEditingController();
  var txtQueQuan = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Thông tin sinh viên"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: txtId,
                decoration: InputDecoration(
                  labelText: "Id",
                ),
              ),
              TextField(
                controller: txtTen,
                decoration: InputDecoration(
                  labelText: "Tên",
                ),
              ),
              TextField(
                controller: txtNgaySinh,
                decoration: InputDecoration(
                  labelText: "Ngày sinh",
                ),
              ),
              TextField(
                controller: txtQueQuan,
                decoration: InputDecoration(
                  labelText: "Quê quán",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        SinhVien sv = SinhVien(
                            id: txtId.text,
                            ten: txtTen.text,
                            ngay_sinh: txtNgaySinh.text,
                            que_quan: txtQueQuan.text
                        );
                        SinhVienSnapshot.addNew(sv);
                      },
                      child: Text("Thêm")
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    txtId.text = "";
    txtTen.text = "";
    txtNgaySinh.text = "";
    txtQueQuan.text = "";
  }
}

