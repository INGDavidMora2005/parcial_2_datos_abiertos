import 'package:go_router/go_router.dart';
import '../views/dashboard/dashboard_view.dart';
import '../views/department/department_list_view.dart';
import '../views/department/department_detail_view.dart';
import '../views/president/president_list_view.dart';
import '../views/president/president_detail_view.dart';
import '../views/region/region_list_view.dart';
import '../views/region/region_detail_view.dart';
import '../views/touristic_attraction/touristic_attraction_list_view.dart';
import '../views/touristic_attraction/touristic_attraction_detail_view.dart';
import '../views/holiday/holiday_list_view.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'dashboard',
      builder: (context, state) => const DashboardView(),
    ),
    GoRoute(
      path: '/departments',
      name: 'departments',
      builder: (context, state) => const DepartmentListView(),
      routes: [
        GoRoute(
          path: ':id',
          name: 'department-detail',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return DepartmentDetailView(id: id);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/presidents',
      name: 'presidents',
      builder: (context, state) => const PresidentListView(),
      routes: [
        GoRoute(
          path: ':id',
          name: 'president-detail',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return PresidentDetailView(id: id);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/regions',
      name: 'regions',
      builder: (context, state) => const RegionListView(),
      routes: [
        GoRoute(
          path: ':id',
          name: 'region-detail',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return RegionDetailView(id: id);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/touristic-attractions',
      name: 'touristic-attractions',
      builder: (context, state) => const TouristicAttractionListView(),
      routes: [
        GoRoute(
          path: ':id',
          name: 'touristic-attraction-detail',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return TouristicAttractionDetailView(id: id);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/holidays',
      name: 'holidays',
      builder: (context, state) => const HolidayListView(),
    ),
  ],
);
