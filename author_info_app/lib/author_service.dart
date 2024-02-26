// author_service.dart

import 'package:dio/dio.dart';

class AuthorService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getAuthorInfo(String authorName) async {
    try {
      final response = await _dio.get(
        'https://openlibrary.org/search/authors.json',
        queryParameters: {'q': authorName},
      );

      final authorData = response.data['docs'][0]; // İlk yazarın bilgilerini alıyoruz.

      return {
        'name': authorData['name'] ?? '',
        'dates': authorData['birth_date'] ?? 'N/A',
        'mostImportantWork': authorData['top_work'] ?? 'N/A',
      };
    } catch (error) {
      throw Exception('Failed to load author information');
    }
  }
}
