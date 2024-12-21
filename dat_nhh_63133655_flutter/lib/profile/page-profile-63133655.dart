import 'package:dat_nhh_63133655_flutter/widgets/dropdown_button.dart';
import 'package:dat_nhh_63133655_flutter/widgets/radio_button.dart';
import 'package:dat_nhh_63133655_flutter/widgets/wrapper_data.dart';
import 'package:flutter/material.dart';

class myProfile extends StatefulWidget {
  const myProfile({super.key});

  @override
  State<myProfile> createState() => _myProfileState();
}

class _myProfileState extends State<myProfile> {
  StringWrapper gioiTinh = StringWrapper(value: "Nam");
  StringWrapper nguoiYeu = StringWrapper(value: "Chưa");
  String? phepTinh = "Cộng";
  List<String> phepTinhs = [
    "Cộng", "Trừ", "Nhân", "Chia", "Biết hết", "Không biết gì hết"
  ];
  StringWrapper monHoc = StringWrapper(value: "Toán");
  DateTime? ngaySinh = DateTime(2003,10,13);
  int index = 0; // index cua nav bar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("My Profile"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage:  AssetImage("asset/images/obama-bin-laden.jpg"),
              ),
              accountName: Text("Nguyễn Hoài Huy Đạt"),
              accountEmail: Text("dat.nhh.63cntt@gmail.com"),
              ),
            GestureDetector(
              onTap: () {
                // Navigate toi trang tuong ung
              },
              child: ListTile(
                leading: Icon(Icons.mail_outline),
                title: Text("Mail"),
                trailing: Text("100"),
              ),
            ),
          ],
        ),
      ),
      body: _buidlBody(context, index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.home, color: Colors.blue,),
              icon: Icon(Icons.home, color: Colors.grey,),
              label: "Home",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.message, color: Colors.blue,),
            icon: Icon(Icons.message, color: Colors.grey,),
            label: "Messages",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.phone, color: Colors.blue,),
            icon: Icon(Icons.phone, color: Colors.grey,),
            label: "Phone",
          ),
        ],
        onTap: (value){
          setState(() {
            index = value;
          });
        },
      ),
    );
  }

  _buidlBody(BuildContext context, int index){
    switch(index){
      case 0: return _buildHome(context);
      case 1: return _buildSMS(context);
      case 2: return _buildPhone(context);
    }
  }

  _buildHome(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 300,
                height: 200,
                child: Image.asset("asset/images/obama-bin-laden.jpg"),
              ),
            ),
            SizedBox(height: 15),
            Text("Họ và tên:"),
            Text("Nguyễn Hoài Huy Đạt", style: TextStyle(color: Colors.pinkAccent, fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Ngày sinh:"),
            Row(
              children: [
                Expanded(child: Text("${ngaySinh?.day?? 1}/${ngaySinh?.month?? 1}/${ngaySinh?.year?? 2000}")),
                IconButton(
                    icon: Icon(Icons.calendar_month),
                    onPressed: () async{
                     DateTime? d = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2050),
                      );
                     if(d!=null){
                       setState(() {
                         ngaySinh = d;
                       });
                     }
                    },
                ),
                SizedBox(width: 20,),
              ],
            ),
            SizedBox(height: 10),
            Text("Giới tính:"),
            MyGroupRadio(labels: ["Nam","Nữ"], groupValue: gioiTinh),
            //Gioi tinh cu
            // Row(
            //   children: [
            //     Expanded(
            //       child: ListTile(
            //         leading: Radio(
            //           groupValue: gioiTinh,
            //           value: "nam",
            //           onChanged: (value){
            //             setState(() {
            //               gioiTinh = value as String;
            //             });
            //           },
            //         ),
            //         title: Text("Nam"),
            //       ),
            //     ),
            //     Expanded(
            //       child: ListTile(
            //         leading: Radio(
            //           groupValue: gioiTinh,
            //           value: "nu",
            //           onChanged: (value){
            //             setState(() {
            //               gioiTinh = value as String;
            //             });
            //           },
            //         ),
            //         title: Text("Nữ"),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 10),
            Text("Quê quán:"),
            Text("Nha Trang, Khánh Hòa", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text("Sở thích:"),
            Text("Cà phê", style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
            SizedBox(height: 10),
            Text("Phép tính giỏi nhất của bạn:"),
            DropdownButton<String>(
                isExpanded: true,
                value: phepTinh,
                items: phepTinhs.map(
                        (phepTinh) => DropdownMenuItem(
                            child: Text(phepTinh), value: phepTinh,
                        )
                ).toList(),
                onChanged: (value){
                  setState(() {
                    phepTinh = value;
                  });
                }
            ),
            SizedBox(height: 10),
            Text("Có người yêu chưa?"),
            MyGroupRadio(labels: ["Chưa","Có"], groupValue: nguoiYeu, isHorizontal: false,),
            SizedBox(height: 10),
            Text("Môn học yêu thích?"),
            MyDropdownButton(
                labels: ["Toán","Văn","Lý","Sinh","Sử","Địa"],
                value: monHoc,
                itemBuilder: (label) => Row(
                  children: [
                    Icon(Icons.content_paste_sharp),
                    Text(label),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }

  _buildSMS(BuildContext context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Messages", style: TextStyle(fontSize: 50),),
        ],
      ),
    );
  }

  _buildPhone(BuildContext context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Phone Calls", style: TextStyle(fontSize: 50),),
        ],
      ),
    );
  }
}
