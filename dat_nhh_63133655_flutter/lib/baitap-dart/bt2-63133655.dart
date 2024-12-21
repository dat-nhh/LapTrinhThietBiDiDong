/*- Khai báo lớp SinhVien bao gồm các thuộc tính:
+ id, ten: bắt buộc.
+ ngaySinh, que_Quan: Không bắt buộc
*/
class SinhVien{
  String id, ten;
  String? ngaySinh, queQuan;

  SinhVien({required this.id, required this.ten, this.ngaySinh, this.queQuan});

  @override
  String toString(){
    return 'SinhVien{id: $id, ten: $ten, ngaySinh: $ngaySinh, queQuan: $queQuan}';
  }
}

class QLSV{
  List<SinhVien> list = [];

  void add(SinhVien sv){
    list.add(sv);
  }

  void inDS(){
    list.forEach((sv) {
      print(sv.toString());
    });
  }

  void inDS2(){
    for(var sv in list)
      print(sv.toString());
  }
}

void main(){
  print("Hello 63.CNTT-1");
  SinhVien sv1 = SinhVien(id: '01', ten: 'Huy Dat', ngaySinh: '1/1/2001', queQuan: 'Nha Trang');
  SinhVien sv2 = SinhVien(id: '02', ten: 'Dat Huy', ngaySinh: '1/2/2003', queQuan: 'Nha Trang');
  QLSV qlsv = QLSV();
  qlsv.add(sv1);
  qlsv.add(sv2);
  qlsv.inDS();
  qlsv.inDS2();
  //Chuyển danh sách các số nguyên thành danh sách bình phương các số nguyên
  List<int> listInt = [];
  List<int> listBinhPhuong = listInt.map((soNguyen) => soNguyen*soNguyen).toList();
  print(listInt);
  print(listBinhPhuong);
}