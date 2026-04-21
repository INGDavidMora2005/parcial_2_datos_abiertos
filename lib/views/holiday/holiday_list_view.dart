import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/holiday_model.dart';
import '../../services/holiday_service.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/error_widget.dart';

class HolidayListView extends StatefulWidget {
  const HolidayListView({super.key});

  @override
  State<HolidayListView> createState() => _HolidayListViewState();
}

class _HolidayListViewState extends State<HolidayListView> {
  late Future<List<Holiday>> _future;
  int _selectedYear = 2023;

  @override
  void initState() {
    super.initState();
    _future = HolidayService.getHolidays(year: _selectedYear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('Festivos'),
        actions: [
          DropdownButton<int>(
            value: _selectedYear,
            dropdownColor: const Color(0xFF003893),
            style: const TextStyle(color: Colors.white),
            underline: const SizedBox(),
            items: List.generate(6, (i) => DateTime.now().year - 3 + i)
                .map(
                  (y) => DropdownMenuItem(
                    value: y,
                    child: Text(
                      '$y',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
                .toList(),
            onChanged: (y) {
              if (y != null) {
                setState(() {
                  _selectedYear = y;
                  _future = HolidayService.getHolidays(year: _selectedYear);
                });
              }
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: FutureBuilder<List<Holiday>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return AppErrorWidget(
              message: snapshot.error.toString(),
              onRetry: () => setState(() {
                _future = HolidayService.getHolidays(year: _selectedYear);
              }),
            );
          }
          final items = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final holiday = items[index];
              final months = [
                '',
                'Ene',
                'Feb',
                'Mar',
                'Abr',
                'May',
                'Jun',
                'Jul',
                'Ago',
                'Sep',
                'Oct',
                'Nov',
                'Dic',
              ];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${holiday.date.day}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6A1B9A),
                        ),
                      ),
                      Text(
                        months[holiday.date.month],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  title: Text(
                    holiday.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(holiday.type ?? ''),
                  trailing: holiday.isPuente == true
                      ? const Chip(
                          label: Text(
                            'Puente',
                            style: TextStyle(fontSize: 11, color: Colors.white),
                          ),
                          backgroundColor: Color(0xFF6A1B9A),
                          padding: EdgeInsets.zero,
                        )
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
