class TouristicAttraction {
  final int id;
  final String name;
  final String? description;
  final String? latitude;
  final String? longitude;
  final int? departmentId;
  final String? departmentName;
  final String? cityName;
  final List<String>? images;

  TouristicAttraction({
    required this.id,
    required this.name,
    this.description,
    this.latitude,
    this.longitude,
    this.departmentId,
    this.departmentName,
    this.cityName,
    this.images,
  });

  factory TouristicAttraction.fromJson(Map<String, dynamic> json) {
    List<String>? imagesList;
    if (json['images'] != null) {
      imagesList = List<String>.from(
        (json['images'] as List)
            .map((img) {
              if (img is Map) return img['url']?.toString() ?? '';
              return img.toString();
            })
            .where((url) => url.isNotEmpty),
      );
    }
    return TouristicAttraction(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'],
      latitude: json['latitude']?.toString(),
      longitude: json['longitude']?.toString(),
      departmentId: json['departmentId'],
      departmentName: json['department']?['name'],
      cityName: json['city']?['name'],
      images: imagesList,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'latitude': latitude,
    'longitude': longitude,
    'departmentId': departmentId,
  };
}
