import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/region_model.dart';
import '../../services/region_service.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/error_widget.dart';

class RegionListView extends StatefulWidget {
  const RegionListView({super.key});

  @override
  State<RegionListView> createState() => _RegionListViewState();
}

class _RegionListViewState extends State<RegionListView> {
  late Future<List<Region>> _future;

  @override
  void initState() {
    super.initState();
    _future = RegionService.getRegions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('Regiones'),
      ),
      body: FutureBuilder<List<Region>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return AppErrorWidget(
              message: snapshot.error.toString(),
              onRetry: () => setState(() {
                _future = RegionService.getRegions();
              }),
            );
          }
          final items = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final region = items[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF2E7D32),
                    child: Text(
                      region.name[0],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    region.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: region.description != null
                      ? Text(
                          region.description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => context.goNamed(
                    'region-detail',
                    pathParameters: {'id': region.id.toString()},
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
