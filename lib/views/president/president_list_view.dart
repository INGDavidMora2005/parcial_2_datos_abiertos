import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/president_model.dart';
import '../../services/president_service.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/error_widget.dart';

class PresidentListView extends StatefulWidget {
  const PresidentListView({super.key});

  @override
  State<PresidentListView> createState() => _PresidentListViewState();
}

class _PresidentListViewState extends State<PresidentListView> {
  late Future<List<President>> _future;

  @override
  void initState() {
    super.initState();
    _future = PresidentService.getPresidents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('Presidentes'),
      ),
      body: FutureBuilder<List<President>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return AppErrorWidget(
              message: snapshot.error.toString(),
              onRetry: () => setState(() {
                _future = PresidentService.getPresidents();
              }),
            );
          }
          final items = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final president = items[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading:
                      president.image != null && president.image!.isNotEmpty
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(president.image!),
                          onBackgroundImageError: (_, _) {},
                        )
                      : CircleAvatar(
                          backgroundColor: const Color(0xFFCE1126),
                          child: Text(
                            president.name[0],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                  title: Text(
                    '${president.name} ${president.lastName ?? ''}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    president.politicalParty ?? 'Partido desconocido',
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => context.goNamed(
                    'president-detail',
                    pathParameters: {'id': president.id.toString()},
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
