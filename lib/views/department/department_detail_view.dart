import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/department_model.dart';
import '../../services/department_service.dart';
import '../../widgets/error_widget.dart';

class DepartmentDetailView extends StatefulWidget {
  final int id;
  const DepartmentDetailView({super.key, required this.id});

  @override
  State<DepartmentDetailView> createState() => _DepartmentDetailViewState();
}

class _DepartmentDetailViewState extends State<DepartmentDetailView> {
  late Future<Department> _future;

  @override
  void initState() {
    super.initState();
    _future = DepartmentService.getDepartmentById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('Detalle Departamento'),
      ),
      body: FutureBuilder<Department>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return AppErrorWidget(
              message: snapshot.error.toString(),
              onRetry: () => setState(() {
                _future = DepartmentService.getDepartmentById(widget.id);
              }),
            );
          }
          final dept = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: const Color(0xFF003893),
                    child: Text(
                      dept.name[0],
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    dept.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildInfoCard([
                  _buildRow(
                    Icons.info_outline,
                    'Descripción',
                    dept.description ?? 'N/A',
                  ),
                  _buildRow(
                    Icons.map,
                    'ID Región',
                    dept.regionId?.toString() ?? 'N/A',
                  ),
                  _buildRow(
                    Icons.straighten,
                    'Superficie',
                    dept.surface ?? 'N/A',
                  ),
                  _buildRow(
                    Icons.people,
                    'Población',
                    dept.population?.toString() ?? 'N/A',
                  ),
                  _buildRow(
                    Icons.phone,
                    'Prefijo telefónico',
                    dept.phonePrefix ?? 'N/A',
                  ),
                  _buildRow(
                    Icons.local_post_office,
                    'Código postal',
                    dept.postalCode ?? 'N/A',
                  ),
                ]),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF003893), size: 20),
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
                    fontSize: 15,
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
