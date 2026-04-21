import '../models/region_model.dart';
import 'api_service.dart';

class RegionService {
  static Future<List<Region>> getRegions() async {
    final data = await ApiService.get('/Region');
    return (data as List).map((e) => Region.fromJson(e)).toList();
  }

  static Future<Region> getRegionById(int id) async {
    final data = await ApiService.get('/Region/$id');
    return Region.fromJson(data);
  }
}
