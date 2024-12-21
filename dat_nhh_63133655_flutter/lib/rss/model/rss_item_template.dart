class RSSItem{
  static late String startDescriptRegrex, endDescriptRegrex;
  static late String startImgRegrex, endImgRegrex;
  String? title;
  String? pubDate;
  String? description;
  String? link;
  String? imgUrl;

  RSSItem.empty();

  String _getDescription(String rawDescript){
    int start = rawDescript.indexOf(startDescriptRegrex) + startDescriptRegrex.length;
    if(start>=startDescriptRegrex.length){
      if(endDescriptRegrex.length>0){
        int end = rawDescript.indexOf(endDescriptRegrex,start);
        return rawDescript.substring(start,end);
      }
      return rawDescript.substring(start);
    }
    return "";
  }

  String? _getImage(String rawDescript){
    int start = rawDescript.indexOf(startImgRegrex) + startImgRegrex.length;
    if(start>=startImgRegrex.length){
      if(endImgRegrex.length>0){
        int end = rawDescript.indexOf(endImgRegrex,start);
        return rawDescript.substring(start,end);
      }
      return rawDescript.substring(start);
    }
    return null;
  }

  RSSItem getFromJson(Map<String, dynamic> json){
    title = json['title'];
    pubDate = json['pubDate'];
    description = _getDescription(json['description']);
    link = json['link'];
    imgUrl = _getImage(json['description']);
    return this;
  }

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'pubDate': this.pubDate,
      'description': this.description,
      'link': this.link,
      'imgUrl': this.imgUrl,
    };
  }
}