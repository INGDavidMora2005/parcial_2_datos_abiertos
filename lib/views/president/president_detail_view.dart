import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/president_model.dart';
import '../../services/president_service.dart';
import '../../widgets/error_widget.dart';

class PresidentDetailView extends StatefulWidget {
  final int id;
  const PresidentDetailView({super.key, required this.id});

  @override
  State<PresidentDetailView> createState() => _PresidentDetailViewState();
}

class _PresidentDetailViewState extends State<PresidentDetailView> {
  late Future<President> _future;

  @override
  void initState() {
    super.initState();
    _future = PresidentService.getPresidentById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('Detalle Presidente'),
      ),
      body: FutureBuilder<President>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return AppErrorWidget(
              message: snapshot.error.toString(),
              onRetry: () => setState(() {
                _future = PresidentService.getPresidentById(widget.id);
              }),
            );
          }
          final p = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: p.image != null && p.image!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: Image.network(
                            p.image!,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => const CircleAvatar(
                              radius: 60,
                              backgroundColor: Color(0xFFCE1126),
                              child: Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : const CircleAvatar(
                          radius: 60,
                          backgroundColor: Color(0xFFCE1126),
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    '${p.name} ${p.lastName ?? ''}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _row(
                          Icons.groups,
                          'Partido político',
                          p.politicalParty ?? 'N/A',
                        ),
                        _row(
                          Icons.calendar_today,
                          'Inicio período',
                          p.startPeriodDate?.substring(0, 10) ?? 'N/A',
                        ),
                        _row(
                          Icons.event,
                          'Fin período',
                          p.endPeriodDate?.substring(0, 10) ?? 'N/A',
                        ),
                        if (p.description != null && p.description!.isNotEmpty)
                          _row(
                            Icons.description,
                            'Descripción',
                            p.description!,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _row(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFCE1126), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
