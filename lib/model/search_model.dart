class SearchResult {
  final String title;
  final String snippet;
  final String url;

  SearchResult({required this.title, required this.snippet, required this.url});

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      title: json['title'] ?? '',
      snippet: json['snippet'] ?? '',
      url: json['link'] ?? '',
    );
  }
}