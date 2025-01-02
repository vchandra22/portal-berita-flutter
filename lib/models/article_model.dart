class Article {
  final String title;
  final String description;
  final String urlToImage;
  final String content;

  Article({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      content: json['content'] ?? '', // Handle null values for content
    );
  }
}
