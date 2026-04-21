import '../models/holiday_model.dart';
import 'api_service.dart';

class HolidayService {
  static Future<List<Holiday>> getHolidays({int? year}) async {
    final yearsToTry = year != null ? [year] : [2024, 2023, 2025, 2022];
    for (final y in yearsToTry) {
      try {
        final data = await ApiService.get('/Holiday/$y');
        return (data as List).map((e) => Holiday.fromJson(e)).toList();
      } catch (e) {
        continue;
      }
    }
    throw ApiException(
      'No se pudieron obtener datos de festivos para los años probados',
      statusCode: 404,
    );
  }
}
