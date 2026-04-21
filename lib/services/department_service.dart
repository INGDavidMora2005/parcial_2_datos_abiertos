import '../models/department_model.dart';
import 'api_service.dart';

class DepartmentService {
  static Future<List<Department>> getDepartments() async {
    final data = await ApiService.get('/Department');
    return (data as List).map((e) => Department.fromJson(e)).toList();
  }

  static Future<Department> getDepartmentById(int id) async {
    final data = await ApiService.get('/Department/$id');
    return Department.fromJson(data);
  }
}
