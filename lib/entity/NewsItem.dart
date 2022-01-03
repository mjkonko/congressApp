class NewsItem {
  final int id;
  final String title;
  final String body ;
  final String time;

  NewsItem({
    required this.id,
    required this.title,
    required this.body,
    required this.time
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        time: json['time']
    );
  }
}