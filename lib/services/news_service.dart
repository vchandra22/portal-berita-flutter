import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsService {
  final String apiKey = '85f3f67b5e134b4db359fba7cc8ab563';
  final String baseUrl = 'https://newsapi.org/v2';

  Future<List<Article>> getTopHeadlines({String category = 'general'}) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/top-headlines?country=us&category=$category&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List articles = data['articles'];
      return articles.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
