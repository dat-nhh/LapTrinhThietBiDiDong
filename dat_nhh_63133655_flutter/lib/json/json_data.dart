import 'dart:convert';
import 'package:http/http.dart' as http;

// {
// "albumId": 1,
// "id": 1,
// "title": "accusamus beatae ad facilis cum similique qui sunt",
// "url": "https://via.placeholder.com/600/92c952",
// "thumbnailUrl": "https://via.placeholder.com/150/92c952"
// }

class Photo{
  int albumId, id;
  String title, url, thumbnailUrl;

  Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'albumId': this.albumId,
      'id': this.id,
      'title': this.title,
      'url': this.url,
      'thumbnailUrl': this.thumbnailUrl,
    };
  }

  factory Photo.fromJson(Map<String, dynamic> map) {
    return Photo(
      albumId: map['albumId'] as int,
      id: map['id'] as int,
      title: map['title'] as String,
      url: map['url'] as String,
      thumbnailUrl: map['thumbnailUrl'] as String,
    );
  }
}

Future<List<Photo>> getHTTP_content() async{
  Uri uri = Uri.parse("https://jsonplaceholder.typicode.com/photos");
  var response = await http.get(uri);
  if(response.statusCode == 200){
    // print(response.body);
    List<dynamic> list = json.decode(response.body) as List;
    return list.map((photoJson) => Photo.fromJson(photoJson)).toList();
  }
  return [];
}