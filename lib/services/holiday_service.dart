import '../models/holiday_model.dart';
import 'api_service.dart';

class HolidayService {
  static Future<List<Holiday>> getHolidays({int? year}) async {
    final targetYear = year ?? DateTime.now().year;

    try {
      // Formato correcto: /Holiday/year/{year}
      final data = await ApiService.get('/Holiday/year/$targetYear');
      return (data as List).map((e) => Holiday.fromJson(e)).toList();
    } catch (e) {
      // Si falla, intentar sin año (devuelve todos)
      try {
        final data = await ApiService.get('/Holiday');
        return (data as List).map((e) => Holiday.fromJson(e)).toList();
      } catch (_) {
        throw ApiException(
          'No se pudieron obtener los festivos',
          statusCode: 404,
        );
      }
    }
  }
}
