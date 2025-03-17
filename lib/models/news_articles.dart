import 'package:flutter/material.dart';
// import '../models/news_articles.dart';
import '../utils/url_launcher.dart';

class NewsArticle {
  final String title;
  final String source;
  final String link;
  final String imageUrl;

  NewsArticle(this.title, this.source, this.link, this.imageUrl);
}

class NewsList extends StatelessWidget {
  final List<NewsArticle> articles;

  const NewsList({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        NewsArticle article = articles[index];

        return Card(
          elevation: 4,
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                article.imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Source: ${article.source}",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () => launchURL(article.link),
                          child: Text('Read More'),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.bookmark_border,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            // Handle save for later logic (redirect to login if not signed in)
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
