class Holiday {
  String? date;
  String? name;
  String? type;

  Holiday({
    this.date,
    this.name,
    this.type,
  });

  // Factory constructor to create a Holiday from JSON
  factory Holiday.fromJson(Map<String, dynamic> json) {
    return Holiday(
      date: json['date'],
      name: json['name'],
      type: json['type'],
    );
  }

  // Method to convert Holiday to JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'name': name,
      'type': type,
    };
  }
}
