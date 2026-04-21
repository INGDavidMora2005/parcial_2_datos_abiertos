import '../models/touristic_attraction_model.dart';
import 'api_service.dart';

class TouristicAttractionService {
  static Future<List<TouristicAttraction>> getAttractions() async {
    final data = await ApiService.get('/TouristicAttraction');
    return (data as List).map((e) => TouristicAttraction.fromJson(e)).toList();
  }

  static Future<TouristicAttraction> getAttractionById(int id) async {
    final data = await ApiService.get('/TouristicAttraction/$id');
    return TouristicAttraction.fromJson(data);
  }
}
