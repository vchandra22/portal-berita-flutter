import 'package:flutter/material.dart';
import 'package:portal_berita/services/news_service.dart';
import '../models/article_model.dart';
import 'article_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Article>> futureArticles;

  @override
  void initState() {
    super.initState();
    futureArticles = NewsService().getTopHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Headlines'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: futureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return const Center(child: Text('No articles found'));
          }

          List<Article> articles = snapshot.data as List<Article>;

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                elevation: 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    articles[index].urlToImage.isNotEmpty
                        ? Image.network(
                            articles[index].urlToImage,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: double.infinity,
                            height: 200,
                            color: Colors.grey[300],
                            child: const Icon(Icons.broken_image, size: 80),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        articles[index].title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        articles[index].description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
