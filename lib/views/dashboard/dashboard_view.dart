import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/dashboard_card.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final endpoints = [
      {
        'title': 'Departamentos',
        'subtitle': 'Explora los 32 departamentos de Colombia',
        'icon': Icons.map_outlined,
        'color': const Color(0xFF003893),
        'route': 'departments',
      },
      {
        'title': 'Presidentes',
        'subtitle': 'Historia de los presidentes colombianos',
        'icon': Icons.person_outline,
        'color': const Color(0xFFCE1126),
        'route': 'presidents',
      },
      {
        'title': 'Regiones',
        'subtitle': 'Las grandes regiones naturales del país',
        'icon': Icons.terrain_outlined,
        'color': const Color(0xFF2E7D32),
        'route': 'regions',
      },
      {
        'title': 'Atractivos Turísticos',
        'subtitle': 'Destinos imperdibles de Colombia',
        'icon': Icons.place_outlined,
        'color': const Color(0xFFE65100),
        'route': 'touristic-attractions',
      },
      {
        'title': 'Festivos',
        'subtitle': 'Días festivos y puentes del año',
        'icon': Icons.celebration_outlined,
        'color': const Color(0xFF6A1B9A),
        'route': 'holidays',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('🇨🇴 Colombia Open Data')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Explorar datos',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003893),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Selecciona una categoría para comenzar',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.5,
                ),
                itemCount: endpoints.length,
                itemBuilder: (context, index) {
                  final ep = endpoints[index];
                  return DashboardCard(
                    title: ep['title'] as String,
                    subtitle: ep['subtitle'] as String,
                    icon: ep['icon'] as IconData,
                    color: ep['color'] as Color,
                    onTap: () => context.goNamed(ep['route'] as String),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
