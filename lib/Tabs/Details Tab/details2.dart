import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // لضمان استخدام خط Roboto إن لم يكن متاحًا بشكل افتراضي
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: const MovieDetailsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Strange Details'),
      ),
      // لعرض المحتوى بشكل متتابع وقابل للتمرير
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // ... هنا يمكن إضافة صورة الفيلم الرئيسية والعنوان والتقييمات ...

            // 1. قسم الأفلام المشابهة (Similar)
            SimilarMoviesSection(),

            Divider(height: 30), // فاصل بين القسمين

            // 2. قسم الملخص (Summary)
            MovieSummarySection(),

            SizedBox(height: 30), // مسافة في نهاية الشاشة
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// (A) كود قسم الملخص (Summary)
// ----------------------------------------------------
class MovieSummarySection extends StatelessWidget {
  const MovieSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // عنوان "Summary"
          Text(
            'Summary',
            style: TextStyle(
              fontWeight: FontWeight.bold, // يماثل 700
              fontSize: 24.0,
            ),
          ),
          SizedBox(height: 15), // مسافة فاصلة

          // نص الملخص
          Text(
            'Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.',
            style: TextStyle(
              fontWeight: FontWeight.normal, // يماثل 400
              fontSize: 16.0,
              height: 1.39, // يماثل Line Height 139%
            ),
          ),
        ],
      ),
    );
  }
}


// ----------------------------------------------------
// (B) كود قسم الأفلام المشابهة (Similar)
// ----------------------------------------------------
class SimilarMoviesSection extends StatelessWidget {
  const SimilarMoviesSection({super.key});

  final List<Map<String, String>> similarMovies = const [
    {
      'title': 'Black Widow', 'rating': '7.7',
      'imageUrl': 'https://image.tmdb.org/t/p/w200/qB7YF4qK33F9j5V45nO4hC1LzQY.jpg',
    },
    {
      'title': 'Captain America: The Winter Soldier', 'rating': '7.7',
      'imageUrl': 'https://image.tmdb.org/t/p/w200/z09nh2uNn9Kx7U0P9p0zY3Y3V1M.jpg',
    },
    {
      'title': 'Avengers: Endgame', 'rating': '7.7',
      'imageUrl': 'https://image.tmdb.org/t/p/w200/or06hWJ2b2d3iBw7M0tF8w5tB5.jpg',
    },
    {
      'title': 'Captain America: Civil War', 'rating': '7.7',
      'imageUrl': 'https://image.tmdb.org/t/p/w200/rltJqLwWdYm8B9e1d8Yj0g3XqM0.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // عنوان "Similar"
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Similar',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
        ),

        // قائمة أفقية بالأفلام المشابهة
        SizedBox(
          height: 279.0, // ارتفاع البطاقات
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: similarMovies.length,
            itemBuilder: (context, index) {
              final movie = similarMovies[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: index == similarMovies.length - 1 ? 16.0 : 0.0,
                ),
                child: MovieCard(
                  imageUrl: movie['imageUrl']!,
                  rating: movie['rating']!,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ----------------------------------------------------
// (C) ويدجت بطاقة الفيلم (MovieCard) - لم يتغير
// ----------------------------------------------------
class MovieCard extends StatelessWidget {
  final String imageUrl;
  final String rating;

  const MovieCard({
    super.key,
    required this.imageUrl,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 189.0, // عرض البطاقة
      margin: const EdgeInsets.only(bottom: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0), // حواف دائرية 16px
        child: Stack(
          children: [
            // صورة الفيلم - تستخدم رابط واقعي
            Positioned.fill(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                // يفضل استخدام حزمة caching_image في تطبيق حقيقي لتحسين الأداء
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              ),
            ),

            // مربع التقييم في الزاوية
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}