class VenueItem {
  final int id;
  final String name;

  VenueItem({
    required this.id,
    required this.name

  });

  factory VenueItem.fromJson(Map<String, dynamic> json) {
    return VenueItem(
        id: json['id'],
        name: json['name']
    );
  }
}