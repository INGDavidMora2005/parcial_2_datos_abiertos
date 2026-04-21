class Holiday {
  final DateTime date;
  final String name;
  final String? type;
  final bool? isPuente;

  Holiday({required this.date, required this.name, this.type, this.isPuente});

  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
    date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
    name: json['name'] ?? '',
    type: json['type'],
    isPuente: json['isPuente'],
  );

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'name': name,
    'type': type,
    'isPuente': isPuente,
  };
}
