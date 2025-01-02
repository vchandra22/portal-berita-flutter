import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsService {
  final String apiKey = 'd419d12a5e0d4334a3d1865cd4fb7761';
  final String baseUrl = 'https://newsapi.org/v2';

  Future<List<Article>> getTopHeadlines(
      {String category = 'general', String query = ''}) async {
    String url =
        '$baseUrl/top-headlines?country=us&category=$category&apiKey=$apiKey';

    // If a search query is provided, update the URL with the query
    if (query.isNotEmpty) {
      url += '&q=$query';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List articles = data['articles'];
      return articles.map((json) => Article.fromJson(json)).toList();
    } else {
      print('Error response body: ${response.body}');
      throw Exception('Failed to load articles');
    }
  }
}
