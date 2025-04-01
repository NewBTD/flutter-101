// news_page.dart
import 'package:flutter/material.dart';
import 'news_detail_page.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final List<Map<String, String>> newsList = [
    {
      'title': 'Flutter 3.0 เปิดตัวอย่างเป็นทางการ',
      'subtitle': 'ฟีเจอร์ใหม่เพียบ ทั้ง macOS, Linux, และ Web',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOTGLpRQIfbiwGixMl9BWIePzWJN4yPc6kQA&s',
    },
    {
      'title': 'Dart 3 มาแล้ว!',
      'subtitle': 'ภาษาที่อยู่เบื้องหลัง Flutter ก็อัปเกรดครั้งใหญ่',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOTGLpRQIfbiwGixMl9BWIePzWJN4yPc6kQA&s',
    },
    {
      'title': 'สัมมนา Flutter ที่กรุงเทพ',
      'subtitle': 'รวมตัวนักพัฒนา Flutter ทั่วประเทศ',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOTGLpRQIfbiwGixMl9BWIePzWJN4yPc6kQA&s',
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredNews = newsList
        .where((news) =>
            news['title']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            news['subtitle']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('ข่าวสาร Flutter')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'ค้นหาข่าว',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredNews.length,
              itemBuilder: (context, index) {
                final news = filteredNews[index];
                return ListTile(
                  leading: Image.network(
                    news['image']!,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                  title: Text(news['title']!),
                  subtitle: Text(news['subtitle']!),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (_, animation, __) {
                          return FadeTransition(
                            opacity: animation,
                            child: NewsDetailPage(
                              title: news['title']!,
                              imageUrl: news['image']!,
                            ),
                          );
                        },
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
