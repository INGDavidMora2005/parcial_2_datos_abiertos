import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/touristic_attraction_model.dart';
import '../../services/touristic_attraction_service.dart';
import '../../widgets/error_widget.dart';

class TouristicAttractionDetailView extends StatefulWidget {
  final int id;
  const TouristicAttractionDetailView({super.key, required this.id});

  @override
  State<TouristicAttractionDetailView> createState() =>
      _TouristicAttractionDetailViewState();
}

class _TouristicAttractionDetailViewState
    extends State<TouristicAttractionDetailView> {
  late Future<TouristicAttraction> _future;

  @override
  void initState() {
    super.initState();
    _future = TouristicAttractionService.getAttractionById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('Detalle Atractivo'),
      ),
      body: FutureBuilder<TouristicAttraction>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return AppErrorWidget(
              message: snapshot.error.toString(),
              onRetry: () => setState(() {
                _future = TouristicAttractionService.getAttractionById(
                  widget.id,
                );
              }),
            );
          }
          final a = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (a.images != null && a.images!.isNotEmpty)
                  SizedBox(
                    height: 220,
                    child: PageView.builder(
                      itemCount: a.images!.length,
                      itemBuilder: (_, i) => Image.network(
                        a.images![i],
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          color: const Color(0xFFE65100).withOpacity(0.2),
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                    height: 180,
                    color: const Color(0xFFE65100).withOpacity(0.15),
                    child: const Center(
                      child: Icon(
                        Icons.place,
                        size: 80,
                        color: Color(0xFFE65100),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        a.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              _row(
                                Icons.location_city,
                                'Ciudad',
                                a.cityName ?? 'N/A',
                              ),
                              _row(
                                Icons.map,
                                'Departamento',
                                a.departmentName ?? 'N/A',
                              ),
                              _row(
                                Icons.gps_fixed,
                                'Latitud',
                                a.latitude ?? 'N/A',
                              ),
                              _row(
                                Icons.gps_not_fixed,
                                'Longitud',
                                a.longitude ?? 'N/A',
                              ),
                              if (a.description != null)
                                _row(
                                  Icons.info_outline,
                                  'Descripción',
                                  a.description!,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
          Icon(icon, color: const Color(0xFFE65100), size: 20),
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
