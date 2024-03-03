
import 'package:dio/dio.dart';

class AuthorService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getAuthorInfo(String authorName) async {
    try {
      final response = await _dio.get(
        'https://openlibrary.org/search/authors.json',
        queryParameters: {'q': authorName},
      );

      final authorData = response.data['docs'][0];

      return {
        'name': authorData['name'] ?? '',
        'dates': authorData['birth_date'] ?? 'N/A',
        'mostImportantWork': authorData['top_work'] ?? 'N/A',
        'key': authorData['key'] ?? '', // Yazarın anahtarını ekliyoruz
      };
    } catch (error) {
      throw Exception('Failed to load author information');
    }
  }

  Future<List<dynamic>> getAuthorWorks(String authorKey) async {
    try {
      final response = await _dio.get(
        'https://openlibrary.org/authors/$authorKey/works.json',
      );

      return response.data['entries'] ?? [];
    } catch (error) {
      throw Exception('Failed to load author works');
    }
  }
}
