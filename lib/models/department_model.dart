class Department {
  final int id;
  final String name;
  final String? description;
  final int? regionId;
  final String? surface;
  final int? population;
  final String? phonePrefix;
  final String? postalCode;

  Department({
    required this.id,
    required this.name,
    this.description,
    this.regionId,
    this.surface,
    this.population,
    this.phonePrefix,
    this.postalCode,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    description: json['description'],
    regionId: json['regionId'],
    surface: json['surface']?.toString(),
    population: json['population'],
    phonePrefix: json['phonePrefix'],
    postalCode: json['postalCode'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'regionId': regionId,
    'surface': surface,
    'population': population,
    'phonePrefix': phonePrefix,
    'postalCode': postalCode,
  };
}
