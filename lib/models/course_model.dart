class CourseModel {
  String? id;
  String? name;
  String? description;
  String? startAt;

  CourseModel({this.id, this.name, this.description, this.startAt});

  static CourseModel fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? '',
      name: json['name'],
      description: json['description'],
      startAt: json['startAt'],
    );
  }
}
