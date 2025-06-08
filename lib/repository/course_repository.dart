import 'dart:convert';

import 'package:flutterapp/utils/constants.dart';
import 'package:flutterapp/models/course_model.dart';
import 'package:http/http.dart' as http;

class CourseRepository {
  final urlCourses = Uri.parse('$URL_MOCKAPI/courses');

  final courseList = <CourseModel>[];

  Future<List<CourseModel>> getAll() async {
    final response = await http.get(urlCourses);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;

      for (var course in jsonData) {
        courseList.add(CourseModel.fromJson(course));
      }
      return courseList;
    }
    throw Exception('Problemas ao carregar os cursos.');
  }
}
