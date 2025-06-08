import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutterapp/models/holiday_model.dart';
import 'package:flutterapp/utils/constants.dart';

class HolidayRepository {
  // Method to fetch holidays from the API
  Future<List<Holiday>> getHolidays() async {
    try {
      // Make the HTTP GET request
      final response = await http.get(Uri.parse(ApiConstants.holidaysUrl));

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> jsonData = jsonDecode(response.body);

        // Convert each JSON object to a Holiday instance
        return jsonData.map((json) => Holiday.fromJson(json)).toList();
      } else {
        // If the request was not successful, throw an exception
        throw Exception('Failed to load holidays: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      throw Exception('Error fetching holidays: $e');
    }
  }
}
