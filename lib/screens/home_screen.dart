import 'package:flutter/material.dart';
import 'package:portal_berita/services/news_service.dart';
import '../models/article_model.dart';
import 'article_detail_screen.dart';
import '../widgets/category_filter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Article>> futureArticles;
  String selectedCategory = 'general';
  String searchQuery = '';

  final List<String> categories = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology'
  ];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureArticles = NewsService().getTopHeadlines(category: selectedCategory);
  }

  void onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
      futureArticles = NewsService()
          .getTopHeadlines(category: selectedCategory, query: searchQuery);
    });
  }

  void onSearchQueryChanged() {
    setState(() {
      searchQuery = _searchController.text;
      futureArticles = NewsService()
          .getTopHeadlines(category: selectedCategory, query: searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Portal Berita',
            style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                    onChanged: (value) => onSearchQueryChanged(),
                  ),
                ),
              ],
            ),
          ),
          CategoryFilter(
            categories: categories,
            selectedCategory: selectedCategory,
            onCategorySelected: onCategorySelected,
          ),
          Expanded(
            child: FutureBuilder(
              future: futureArticles,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData ||
                    (snapshot.data as List).isEmpty) {
                  return const Center(child: Text('No articles found'));
                }

                List<Article> articles = snapshot.data as List<Article>;

                return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticleDetailScreen(
                              article: articles[index],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
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
                                    child: const Icon(Icons.broken_image,
                                        size: 80),
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                articles[index].title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                articles[index].description,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueGrey,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
