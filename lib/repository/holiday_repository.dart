import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutterapp/models/holiday_model.dart';
import 'package:flutterapp/utils/constants.dart';

class HolidayRepository {
  Future<List<Holiday>> getHolidays() async {
    try {
      final response = await http.get(Uri.parse(URL_FERIADOS));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        return jsonData.map((json) => Holiday.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao carregar os feriados: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error buscando feriados: $e');
    }
  }
}
