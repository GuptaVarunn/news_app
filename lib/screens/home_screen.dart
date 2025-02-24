import 'package:flutter/material.dart';
import '../models/news_articles.dart';
import '../utils/url_launcher.dart';
import '../utils/shared_prefs.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class NewsHomePage extends StatefulWidget {
  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  String selectedCategory = 'India';
  String? userEmail;

  final Map<String, List<NewsArticle>> newsData = {
    'India': [
      NewsArticle(
        'India Budget 2025 Highlights',
        'NDTV',
        'https://www.ndtv.com',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSosMm4I13FJmm7-nYRYYeBnE8lfBhv_ErMlQ&s',
      ),
      NewsArticle(
        'India vs England Test Match Updates',
        'ESPN',
        'https://www.espncricinfo.com',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSosMm4I13FJmm7-nYRYYeBnE8lfBhv_ErMlQ&s',
      ),
    ],
    'World': [
      NewsArticle(
        'Global Market Crash Impact',
        'BBC',
        'https://www.bbc.com',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSosMm4I13FJmm7-nYRYYeBnE8lfBhv_ErMlQ&s',
      ),
    ],
    'Sports': [
      NewsArticle(
        'Champions League Semi-Finals',
        'Sky Sports',
        'https://www.skysports.com',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSosMm4I13FJmm7-nYRYYeBnE8lfBhv_ErMlQ&s',
      ),
    ],
    'Tech': [
      NewsArticle(
        'AI Breakthrough in 2025',
        'TechCrunch',
        'https://techcrunch.com',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSosMm4I13FJmm7-nYRYYeBnE8lfBhv_ErMlQ&s',
      ),
    ],
  };

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    String? email = await SharedPrefsHelper.getUserEmail();
    setState(() {
      userEmail = email;
    });
  }

  void _logout() async {
    await SharedPrefsHelper.clearUserData();
    setState(() {
      userEmail = null;
    });

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void _navigateToAuth() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => userEmail == null ? SignupPage() : LoginPage(),
      ),
    ).then((_) => _loadUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        backgroundColor: Colors.blueAccent,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.person),
            onSelected: (value) {
              if (value == 'Logout') {
                _logout();
              } else {
                _navigateToAuth();
              }
            },
            itemBuilder: (context) => [
              if (userEmail != null)
                PopupMenuItem(value: 'Logout', child: Text('Logout')),
              if (userEmail == null)
                PopupMenuItem(value: 'Login', child: Text('Login / Sign Up')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Horizontal Navigation Bar
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: newsData.keys.map((category) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedCategory == category ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    child: Text(
                      category,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // News List
          Expanded(
            child: ListView.builder(
              itemCount: newsData[selectedCategory]!.length,
              itemBuilder: (context, index) {
                NewsArticle article = newsData[selectedCategory]![index];

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
                      ListTile(
                        title: Text(
                          article.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Source: ${article.source}"),
                        trailing: IconButton(
                          icon: Icon(Icons.bookmark_border, color: Colors.blueAccent),
                          onPressed: () {
                            _navigateToAuth();
                          },
                        ),
                        onTap: () {
                          launchURL(article.link);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
