import 'package:dat_nhh_63133655_flutter/rss/model/rss_item_template.dart';
import 'package:dat_nhh_63133655_flutter/rss/model/rss_resource.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class SimpleControllerRss extends GetxController{
  List<RssResource> _resources = rssResource;
  RssResource _current = rssResource[0];
  String? rssUrl;
  String? _resourceHeader;
  var _rssList = <RSSItem>[];

  List<RSSItem> get rssList => _rssList;
  String get resourceName => _current.name;
  String? get resourceHeader => _resourceHeader;
  List<String> get headerResources => _current.resourceHeader.keys.toList();
  static SimpleControllerRss get instance => Get.find<SimpleControllerRss>();
  @override
  void onInit() {
    super.onInit();
    if(rssUrl==null)
      rssUrl = _current.resourceHeader.values.toList()[0];
    if(_resourceHeader==null)
      _resourceHeader = _current.resourceHeader.keys.toList()[0];
    _setRegrex();
  }

  @override
  void onReady() {
    super.onReady();
    readRSS();
  }

  void _setRegrex(){
    RSSItem.startDescriptRegrex = _current.startDescriptRegrex;
    RSSItem.endDescriptRegrex = _current.endDescriptRegrex;
    RSSItem.startImgRegrex = _current.startImgRegrex;
    RSSItem.endImgRegrex = _current.endImgRegrex;
  }

  Future<void> readRSS() async{
    _fetchRSS(rssUrl!)
        .then((value){
          _rssList = value?.map((rssMap) => RSSItem.empty().getFromJson(rssMap)).toList()?? [];
          print(rssList[0].link);
          update(["listRss"]);
    })
        .catchError((error){
          print(error);
    });
  }

  Future<List<dynamic>?> _fetchRSS(String rssURL) async{
    Uri uri = Uri.parse(rssURL);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      final xml2json = Xml2Json();
      xml2json.parse(utf8.decode(response.bodyBytes));
      String rssJson = xml2json.toParker();
      Map<String, dynamic> jsonData = jsonDecode(rssJson);
      return(jsonData["rss"]["channel"]["item"]);
    }
    return Future.error("Lỗi đọc RSS");
  }
}

class RssBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(SimpleControllerRss());
  }
}