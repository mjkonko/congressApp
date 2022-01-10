class NewsItem {
  final int id;
  final String time;
  final String title;
  final String body ;

  NewsItem({
    required this.id,
    required this.time,
    required this.title,
    required this.body,

  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
        id: json['id'],
        time: json['time'],
        title: json['title'],
        body: json['body']
    );
  }
}