import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterapp/models/holiday_model.dart';
import 'package:flutterapp/repository/holiday_repository.dart';
import 'package:intl/intl.dart';

class HolidayScreen extends StatefulWidget {
  const HolidayScreen({super.key});

  @override
  State<HolidayScreen> createState() => _HolidayScreenState();
}

class _HolidayScreenState extends State<HolidayScreen> {
  late Future<List<Holiday>> _holidaysFuture;
  final HolidayRepository _repository = HolidayRepository();

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return 'N/A';
    }

    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  String formatType(String? typeStr) {
    if (typeStr == null || typeStr.isEmpty) {
      return 'N/A';
    }

    if (typeStr == 'national') {
      return 'Nacional';
    }

    return typeStr;
  }

  @override
  void initState() {
    super.initState();
    _holidaysFuture = _repository.getHolidays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feriados Nacionais 2023'),
      ),
      body: FutureBuilder<List<Holiday>>(
        future: _holidaysFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Erro ao carregar feriados:\n${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _holidaysFuture = _repository.getHolidays();
                      });
                    },
                    child: const Text('Tentar Novamente'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum feriado encontrado',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            final holidays = snapshot.data!;
            return ListView.builder(
              itemCount: holidays.length,
              itemBuilder: (context, index) {
                final holiday = holidays[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {},
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          icon: Icons.info,
                          label: 'Detalhes',
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        child: Icon(Icons.calendar_today, color: Colors.white),
                      ),
                      title: Text(
                        holiday.name ?? 'Sem nome',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Data: ${formatDate(holiday.date)}'),
                          Text('Tipo: ${formatType(holiday.type)}'),
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
