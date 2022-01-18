class SpeakerItem {
  final int id;
  final String name;

  SpeakerItem({
    required this.id,
    required this.name

  });

  factory SpeakerItem.fromJson(Map<String, dynamic> json) {
    return SpeakerItem(
        id: json['id'],
        name: json['name']
    );
  }
}