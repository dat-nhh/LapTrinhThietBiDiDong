class RssResource{
  String id, name;
  String startDescriptRegrex, endDescriptRegrex;
  String startImgRegrex, endImgRegrex;
  Map<String, String> resourceHeader;

  RssResource({
    required this.id,
    required this.name,
    required this.startDescriptRegrex,
    required this.endDescriptRegrex,
    required this.startImgRegrex,
    required this.endImgRegrex,
    required this.resourceHeader,
  });
}

List<RssResource> rssResource = [
  RssResource(
      id: "vnexpress",
      name: "VN Express",
      startDescriptRegrex: "</a></br>", endDescriptRegrex: "",
      startImgRegrex: 'img src="', endImgRegrex: '">',
      resourceHeader: {
        "Trang chủ" : "https://vnexpress.net/rss/tin-moi-nhat.rss",
        "Thế giới" : "https://vnexpress.net/rss/the-gioi.rss",
        "Giải trí" : "https://vnexpress.net/rss/giai-tri.rss",
        "Khoa học" : "https://vnexpress.net/rss/khoa-hoc.rss",
        "Giáo dục" : "https://vnexpress.net/rss/giao-duc.rss",
        "Cười" : "https://vnexpress.net/rss/cuoi.rss",
      }),
  RssResource(
      id: "thanhnien",
      name: "Báo Thanh Niên",
      startDescriptRegrex: "</a>", endDescriptRegrex: "",
      startImgRegrex: 'img src="', endImgRegrex: '">',
      resourceHeader: {
        "Trang chủ" : "https://thanhnien.vn/rss/home.rss",
        "Thời sự" : "https://thanhnien.vn/rss/thoi-su.rss",
        "Thế giới " : "https://thanhnien.vn/rss/the-gioi.rss",
        "Kinh tế " : "https://thanhnien.vn/rss/kinh-te.rss",
        "Giáo dục" : "https://thanhnien.vn/rss/giao-duc.rss",
        "Giải trí" : "https://thanhnien.vn/rss/giai-tri.rss",
      })
];