class President {
  final int id;
  final String name;
  final String? lastName;
  final String? startPeriodDate;
  final String? endPeriodDate;
  final String? politicalParty;
  final String? image;
  final String? description;

  President({
    required this.id,
    required this.name,
    this.lastName,
    this.startPeriodDate,
    this.endPeriodDate,
    this.politicalParty,
    this.image,
    this.description,
  });

  factory President.fromJson(Map<String, dynamic> json) => President(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    lastName: json['lastName'],
    startPeriodDate: json['startPeriodDate'],
    endPeriodDate: json['endPeriodDate'],
    politicalParty: json['politicalParty'],
    
    image: (json['image'] == null ||
            json['image'] == 'null' ||
            json['image'].toString().trim().isEmpty)
        ? null
        : json['image'],
    description: json['description'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'lastName': lastName,
    'startPeriodDate': startPeriodDate,
    'endPeriodDate': endPeriodDate,
    'politicalParty': politicalParty,
    'image': image,
    'description': description,
  };
}
