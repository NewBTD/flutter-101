import 'package:flutter/material.dart';

class NewsDetailPage extends StatefulWidget {
  final String title;
  final String imageUrl;

  const NewsDetailPage({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  late Future<String> contentFuture;

  @override
  void initState() {
    super.initState();
    contentFuture = fetchNewsContent(widget.title); // mock API
  }

  Future<String> fetchNewsContent(String title) async {
    await Future.delayed(const Duration(seconds: 2)); // จำลองรอโหลด
    return 'นี่คือรายละเอียดเต็มของข่าว \"$title\" ซึ่งเราดึงมาจาก API จำลอง...';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('รายละเอียดข่าว')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            FutureBuilder<String>(
              future: contentFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Text('เกิดข้อผิดพลาดในการโหลดเนื้อหา');
                } else {
                  return Text(
                    snapshot.data!,
                    style: const TextStyle(fontSize: 16),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
