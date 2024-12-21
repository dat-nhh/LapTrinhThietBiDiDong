import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

String _URLVnExprexx = "https://vnexpress.net/rss/tin-moi-nhat.rss";
String _URLBaoThanhNien = "https://thanhnien.vn/rss/home.rss";
String _URLTuoiTre = "https://tuoitre.vn/rss/tin-moi-nhat.rss";

void main() async{
  Uri uri = Uri.parse(_URLVnExprexx);
  final response = await http.get(uri);
  if(response.statusCode == 200){
    final xml2json = Xml2Json();
    xml2json.parse(utf8.decode(response.bodyBytes));
    String rssJson = xml2json.toParker();
    // print(rssJson);
    Map<String, dynamic> jsonData = jsonDecode(rssJson);
    var data = jsonData["rss"]["channel"]["item"][0];
    print(data["title"]);
    print(data["link"]);
    print(data["pubDate"]);
    print(data["description"]);
  }
}