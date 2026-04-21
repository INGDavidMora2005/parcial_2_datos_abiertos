import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/region_model.dart';
import '../../services/region_service.dart';
import '../../widgets/error_widget.dart';

class RegionDetailView extends StatefulWidget {
  final int id;
  const RegionDetailView({super.key, required this.id});

  @override
  State<RegionDetailView> createState() => _RegionDetailViewState();
}

class _RegionDetailViewState extends State<RegionDetailView> {
  late Future<Region> _future;

  @override
  void initState() {
    super.initState();
    _future = RegionService.getRegionById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('Detalle Región'),
      ),
      body: FutureBuilder<Region>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return AppErrorWidget(
              message: snapshot.error.toString(),
              onRetry: () => setState(() {
                _future = RegionService.getRegionById(widget.id);
              }),
            );
          }
          final region = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: const Color(0xFF2E7D32),
                    child: Text(
                      region.name[0],
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    region.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (region.description != null)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: Color(0xFF2E7D32),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              region.description!,
                              style: const TextStyle(fontSize: 15, height: 1.5),
                            ),
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
}
