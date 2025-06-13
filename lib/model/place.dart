class Place {
  final String name;
  final String image;
  final String description;

  Place({
    required this.name,
    required this.image,
    required this.description,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'],
      image: json['image'],
      description: json['description'],
    );
  }
}